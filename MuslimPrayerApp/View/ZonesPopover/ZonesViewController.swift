/*
 * Copyright 2022 Shahul Hameed Shaik
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  ZonesViewController.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 10/04/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol ZonesViewControllerDelegate {
    func onDidSelect(row: (key: String, value: String))
}

class ZonesViewController: UIViewController {
    
    @IBOutlet weak var chooseZonePlaceHolderLabel: UILabel!
    @IBOutlet weak var zoneTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    
    private let disposeBag = DisposeBag()
    var viewModel: ESolatViewModel!
    var coordinator: ZonesViewCoordinator!
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<ZoneSectionData>(configureCell: configureCell, titleForHeaderInSection: titleForHeaderInSection)
    
    private lazy var configureCell: RxTableViewSectionedReloadDataSource<ZoneSectionData>.ConfigureCell = { [weak self] (dataSource, tableView, indexPath, item) in
        let cell = tableView.dequeueReusableCell(withIdentifier: "zonecell", for: indexPath) as! ZoneTableViewCell
        cell.updateCell(desc: "\(item.key ?? "") - \(item.description ?? "")")
        return cell
    }
    
    private lazy var titleForHeaderInSection: RxTableViewSectionedReloadDataSource<ZoneSectionData>.TitleForHeaderInSection = { [weak self] (dataSource, indexPath) in
        return dataSource.sectionModels[indexPath].header
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        setAccessvilityIdentifierForUITesting()
        setupBindings()
        viewModel.fetchZoneTableData()
    }
    
    @IBAction func tapOnCancel(_ sender: Any) {
        coordinator.stop()
    }
    
}

extension ZonesViewController {
    
    func initCommon() {
        zoneTableView.register(UINib(nibName: "ZoneTableViewCell", bundle: nil), forCellReuseIdentifier: "zonecell")
        zoneTableView.register(UINib(nibName: "ZoneTableViewHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "zoneSectionCell")
        
        zoneTableView.separatorStyle = .none
        
        zoneTableView.rx
          .setDelegate(self)
          .disposed(by: disposeBag)
        
        zoneTableView.rx
            .modelSelected(ZoneData.self)
            .subscribe(onNext: { item in
                print("itemSelected: \(String(describing: item.description))")
                self.coordinator.onDidSelect(row: (item.key ?? "", item.description ?? ""))
                self.coordinator.stop()
            }).disposed(by: disposeBag)
    }
    
}

extension ZonesViewController {
    
    func setupBindings() {
        viewModel
            .zoneTableDataPublish
            .bind(to: zoneTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension ZonesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "zoneSectionCell") as? ZoneTableViewHeaderCell {
            headerView.zoneSectionTitle.font = UIFont(name: "Roboto-Bold", size: 19)
            headerView.zoneSectionTitle.textColor = .orange
            return headerView
        }

        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}


//MARK: - Set AccessibilityIdentifierfor UITesting

extension ZonesViewController {
    
    func setAccessvilityIdentifierForUITesting() {
        chooseZonePlaceHolderLabel.accessibilityIdentifier = "chooseZonePlaceHolderLabel"
        zoneTableView.accessibilityIdentifier = "zoneTableView"
        cancelButton.accessibilityIdentifier = "cancelButton"
    }
    
}
