//
//  ZonesViewController.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 10/04/2022.
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
    
    private let disposeBag = DisposeBag()
    private let viewModel = ESolatViewModel()
    var delegate: ZonesViewControllerDelegate?
    
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
        setupBindings()
        viewModel.fetchZoneTableData()
    }
    
    @IBAction func tapOnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
                self.delegate?.onDidSelect(row: (item.key ?? "", item.description ?? ""))
                self.dismiss(animated: true, completion: nil)
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
