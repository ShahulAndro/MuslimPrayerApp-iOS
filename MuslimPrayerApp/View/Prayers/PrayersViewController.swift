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
//  PrayersViewController.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 06/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import UIKit
import RxSwift
import RxCocoa


enum PrayerTimeType {
    case Next, Previous
}

class PrayersViewController: UIViewController {
    
    @IBOutlet weak var rootContentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var prayerBGImageView: UIImageView!
    @IBOutlet weak var settingsImageView: UIImageView!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var eDateLabel: UILabel!
    @IBOutlet weak var iDateLabel: UILabel!
    @IBOutlet weak var nextPrayerTimeLabel: UILabel!
    @IBOutlet weak var prayerTypeLabel: UILabel!
    @IBOutlet weak var prayerTimeLabel: UILabel!
    @IBOutlet weak var timeRemainingForPrayerView: UIView!
    @IBOutlet weak var selectZoneButton: UIButton!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minsLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var zoneLabel: UILabel!
    @IBOutlet weak var prayerDateSelectionView: UIView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var islamicDateLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prayerView: UIView!
    @IBOutlet weak var prayerTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    private var isCountdownTimerInvalidate = false
    private var countDownToDate: Date?
    private var countDownTimer: Timer?
    private let disposeBag = DisposeBag()
    
    var viewModel: ESolatViewModel!
    var coordinator: PrayersViewCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        updateHeaderHeightConstraint()
        setAccessvilityIdentifierForUITesting()
        setupBindings()
        
        viewModel.fetchTakwimSolat()
        
        let tapGesture = UITapGestureRecognizer(target:self, action:#selector((tapOnSettings)))
        settingsImageView.isUserInteractionEnabled = true
        settingsImageView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if  let currentDisplayDate = UserDefaultHelper.currentDisplayDate(), !currentDisplayDate.isEmpty,  !Utils.isToday(currentDisplayDate) {
            viewModel.fetchTakwimSolat()
        }
    }
    
    
    @IBAction func tapOnPreviousButton(_ sender: Any) {
        viewModel.fetchTakwimSolatByPeriod(type: .Previous)
    }
    
    
    @IBAction func tapOnNextButton(_ sender: Any) {
        viewModel.fetchTakwimSolatByPeriod(type: .Next)
    }
    
    @IBAction func tapOnSelectZone(_ sender: Any) {
        coordinator.showZones()
    }
    
    @objc func tapOnSettings() {
        coordinator.showSettings()
    }
    
}

//MARK: - init common

extension PrayersViewController {
    
    private func initCommon() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        prayerTableView.register(UINib(nibName: "PrayerTableViewCell", bundle: nil), forCellReuseIdentifier: "prayerTimeCell")
        
        addGradientToPrayerReminingTimeLabel()
        
        nextButton.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        nextButton.setTitle("", for: .normal)
        previousButton.setImage(UIImage(systemName: "arrowtriangle.backward.fill"), for: .normal)
        previousButton.setTitle("", for: .normal)
    }
    
    private func addGradientToPrayerReminingTimeLabel() {
        hoursLabel.addBorderGradient()
        minsLabel.addBorderGradient()
        secLabel.addBorderGradient()
    }
    
}

//MARK: - ZonesListTableViewControllerProtocol

extension PrayersViewController {
    
    func onDidSelect(row: (key: String, value: String)) {
        UserDefaultHelper.setSelectedZone(code: row.key, value: row.value)
        viewModel.fetchTakwimSolat()
    }
    
}

//MARK: - ViewModel Binding

extension PrayersViewController {
    
    func setupBindings() {
        
        //Update the PrayerHeaderView
        viewModel
            .takwimSolatData
            .bind(onNext: {[weak self] (takwimSolatData) in
                self?.updateTakwimSolat(takwimSolatData)
            })
            .disposed(by: disposeBag)
        
        //Update Tomorrow prayer type and time after Isha for today
        viewModel
            .showTomorrowPrayerTime
            .bind(onNext: {[weak self] (prayerType, prayerTime, date) in
                self?.prayerTypeLabel.text = prayerType
                self?.prayerTimeLabel.text = prayerTime
                
                self?.viewModel.currentPrayer = (prayerType, prayerTime)
                
                if let type = Utils.prayerNames[prayerType] {
                    self?.viewModel.fetchBGImageByPrayerTime(prayterType: type)
                }
                
                if !prayerTime.isEmpty {
                    self?.startTimerForNotifyPrayerTime(nextPrayerTime: prayerTime, dateString: date)
                    self?.viewModel.fetchBGImageByPrayerTime(prayterType: Utils.prayerNames[prayerType]!)
                }
            })
            .disposed(by: disposeBag)
        
        // Update TableView with Prayer Times, next and previous views
        viewModel
            .takwimSolatDataByPeriod
            .bind(onNext: { [weak self] (takwimSolatData) in
                if let prayerTime = takwimSolatData.prayerTime?.first {
                    self?.viewModel.currentSelectePrayerTimeInTable = prayerTime.date ?? ""
                    self?.islamicDateLabel.text = "\(prayerTime.date ?? "")\n\(prayerTime.day ?? "")"
                    if let prayerTimes = self?.viewModel.getPrayerTimeList(prayerTime) {
                        self?.viewModel.prayerTimes.onNext(prayerTimes)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        viewModel
            .prayerTimes
            .bind(to: prayerTableView.rx.items(cellIdentifier: "prayerTimeCell", cellType: PrayerTableViewCell.self)) {  (row,prayer,cell) in
                cell.update(prayerType: prayer.name, prayerTime: prayer.time)
            }
            .disposed(by: disposeBag)
        
        //To animate bg images for prayer
        viewModel
            .bgImagePrayerImages
            .observe(on: MainScheduler.instance)
            .bind(onNext: {[weak self] (images) in
                self?.loadingIndicator.stopAnimating()
                self?.loadingIndicator.isHidden = true
                
                let animatedImages = UIImage.animatedImage(with: images, duration: 30)
                self?.prayerBGImageView.animationDuration = 5
                self?.prayerBGImageView.image = animatedImages
                self?.prayerBGImageView.tintColor = .green
            })
            .disposed(by: disposeBag)
        
        //Schedule Local Notifications
        viewModel
            .scheduleNotificationsWithSolatData
            .bind(onNext: { (solatInfo) in
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.scheduleLocalNotifications(solatData: solatInfo)
            }).disposed(by: disposeBag)
    }
    
}


//MARK: - Helper methods

extension PrayersViewController {
    
    private func updateTakwimSolat(_ takwimSolatData: TakwimSolatData) {
        if let prayerTimeInfo = takwimSolatData.prayerTime?.first {
            eDateLabel.text = Utils.getGregorianDate()
            iDateLabel.text = Utils.getHijriDate(prayerTimeInfo.hijri ?? "")
            nextPrayerTimeLabel.text = "Next Prayer Time"
            
            UserDefaultHelper.setCurrentDisplayDate(currentDisplayDate: prayerTimeInfo.date ?? "")
            islamicDateLabel.text = "\(prayerTimeInfo.date ?? "")\n\(prayerTimeInfo.day ?? "")"
            
            updateNearPrayerTime(solat: prayerTimeInfo)
            loadPrayerTableView(solat: prayerTimeInfo)
        }
        

        if let zoneKey = takwimSolatData.zone {
            zoneLabel.text = "\(ZonesTableData.zoneValue(by: zoneKey)), \(ZonesTableData.section(by: zoneKey))"
//            zoneLabel.marquee()
        }
    }
    
    private func updateNearPrayerTime(solat: TakwimSolat) {
        let nearPrayer = Utils.getNearestPrayerWith(solat)
        viewModel.currentPrayer = (nearPrayer.prayerType, nearPrayer.prayerTime)
        
        if nearPrayer.prayerTime.isEmpty && nearPrayer.prayerType.isEmpty {
            var date = Date().dateStringddMMMyyy
            if  let currentDisplayDate = UserDefaultHelper.currentDisplayDate(), !currentDisplayDate.isEmpty {
                date = currentDisplayDate
            }
            viewModel.fetchTakwimSolat(period: "date", date: Utils.getDateFormatForApiFromddMMMyyyy(dateString: date, type: .Next))
        } else {
            prayerTypeLabel.text = nearPrayer.prayerType
            prayerTimeLabel.text = nearPrayer.prayerTime
        }
        
        if !nearPrayer.prayerTime.isEmpty {
            startTimerForNotifyPrayerTime(nextPrayerTime: nearPrayer.prayerTime)
            viewModel.fetchBGImageByPrayerTime(prayterType: Utils.prayerNames[nearPrayer.prayerType]!)
        }
    }
    
    private func loadPrayerTableView(solat: TakwimSolat) {
        viewModel.currentSelectePrayerTimeInTable = solat.date ?? ""
        viewModel.prayerTimes.onNext(viewModel.getPrayerTimeList(solat))
    }
}

//MARK: - Remaining Prayer Timer

extension PrayersViewController {
    
    private func startTimerForNotifyPrayerTime(nextPrayerTime: String, dateString: String = "") {
        isCountdownTimerInvalidate = false
        
        let date = (!dateString.isEmpty &&  Utils.isToday(dateString)) ? Date().dayAfter : Date()
        let timeComponents = nextPrayerTime.components(separatedBy: ":")
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        if Utils.isDateInTomorrowWithYYYYMMDD(dateString) {
            components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date.dayAfter)
        }
        
        components.hour = Int(timeComponents[0])
        components.minute = Int(timeComponents[1])
        components.second = Int(timeComponents[2])
        
        countDownToDate = calendar.date(from: components)
        countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        
        if isCountdownTimerInvalidate {
            return
        }
        
        let currentDate = Date()
        let calendar = Calendar.current

        let diffDateComponents = calendar.dateComponents([.hour, .minute, .second], from: currentDate, to: countDownToDate! as Date)
        
        let hours = diffDateComponents.hour ?? 0
        let mins = diffDateComponents.minute ?? 0
        let secs = diffDateComponents.second ?? 0
        hoursLabel.text = String(format: "%02d", hours)
        minsLabel.text = String(format: "%02d", mins)
        secLabel.text = String(format: "%02d", secs)
        
        stopTimerAndFetchNewSolat(hours, mins, secs)
    }
    
    func stopTimerAndFetchNewSolat(_ hours: Int, _ mins: Int, _ secs: Int) {
        if hours <= 0 && mins <= 0 && secs <= 0 {
            countDownTimer?.invalidate()
            isCountdownTimerInvalidate = true
            if let currentPrayer = viewModel.currentPrayer, currentPrayer.name == PrayerType.Isha.rawValue || (currentPrayer.name.isEmpty && currentPrayer.time.isEmpty) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MMM-yyyy"
                var date = dateFormatter.string(from: Date())
                if  let currentDisplayDate = UserDefaultHelper.currentDisplayDate(), !currentDisplayDate.isEmpty {
                    date = currentDisplayDate
                }
                viewModel.fetchTakwimSolat(period: "date", date: Utils.getDateFormatForApiFromddMMMyyyy(dateString: date, type: .Next))
            } else {
                viewModel.fetchTakwimSolat()
            }
        }
    }
}

//MARK: - Update Constraints

extension PrayersViewController {
    
    func updateHeaderHeightConstraint() {
        let screenMaxLength = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        if UIDevice.current.userInterfaceIdiom == .phone && screenMaxLength == 667.0 || UIDevice.current.userInterfaceIdiom == .phone && screenMaxLength == 736.0 {
            NSLayoutConstraint.setMultiplier(0.45, of: &headerViewHeightConstraint)
        }
    }
    
}

//MARK: - Set AccessibilityIdentifierfor UITesting

extension PrayersViewController {
    
    func setAccessvilityIdentifierForUITesting() {
        rootContentView.accessibilityIdentifier = "rootContentView"
        headerView.accessibilityIdentifier = "headerView"
        prayerBGImageView.accessibilityIdentifier = "prayerBGImageView"
        settingsImageView.accessibilityIdentifier = "settingsImageView"
        headerStackView.accessibilityIdentifier = "headerStackView"
        eDateLabel.accessibilityIdentifier = "eDateLabel"
        iDateLabel.accessibilityIdentifier = "iDateLabel"
        nextPrayerTimeLabel.accessibilityIdentifier = "nextPrayerTimeLabel"
        prayerTypeLabel.accessibilityIdentifier = "prayerTypeLabel"
        prayerTimeLabel.accessibilityIdentifier = "prayerTimeLabel"
        timeRemainingForPrayerView.accessibilityIdentifier = "timeRemainingForPrayerView"
        hoursLabel.accessibilityIdentifier = "hoursLabel"
        minsLabel.accessibilityIdentifier = "minsLabel"
        secLabel.accessibilityIdentifier = "secLabel"
        zoneLabel.accessibilityIdentifier = "zoneLabel"
        selectZoneButton.accessibilityIdentifier = "selectZoneButton"
        prayerDateSelectionView.accessibilityIdentifier = "prayerDateSelectionView"
        previousButton.accessibilityIdentifier = "previousButton"
        islamicDateLabel.accessibilityIdentifier = "islamicDateLabel"
        nextButton.accessibilityIdentifier = "nextButton"
        prayerView.accessibilityIdentifier = "prayerView"
        prayerTableView.accessibilityIdentifier = "prayerTableView"
        loadingIndicator.accessibilityIdentifier = "loadingIndicator"
    }
    
}
