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
    
    private var isCountdownTimerInvalidate = false
    private var countDownToDate: Date?
    private var countDownTimer: Timer?
    private let disposeBag = DisposeBag()
    private var eSolatViewModel = ESolatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        setupBindings()
        eSolatViewModel.fetchTakwimSolat()
        
        let tapGesture = UITapGestureRecognizer(target:self, action:#selector((tapOnSettings)))
        settingsImageView.isUserInteractionEnabled = true
        settingsImageView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !eSolatViewModel.currentDisplayDate.isEmpty && !Utils.isToday(eSolatViewModel.currentDisplayDate) {
            eSolatViewModel.fetchTakwimSolat()
        }
    }
    
    
    @IBAction func tapOnPreviousButton(_ sender: Any) {
        eSolatViewModel.fetchTakwimSolatByPeriod(type: .Previous)
    }
    
    
    @IBAction func tapOnNextButton(_ sender: Any) {
        eSolatViewModel.fetchTakwimSolatByPeriod(type: .Next)
    }
    
    @IBAction func tapOnSelectZone(_ sender: Any) {
        let vc = ZonesViewController()
        vc.modalPresentationStyle = .popover
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @objc func tapOnSettings() {
        let vc = SettingsViewController()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true, completion: nil)
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

extension PrayersViewController: ZonesViewControllerDelegate {
    
    func onDidSelect(row: (key: String, value: String)) {
        eSolatViewModel.currentZone = row.key
        eSolatViewModel.fetchTakwimSolat(zone: row.key)
    }
    
}

//MARK: - ViewModel Binding

extension PrayersViewController {
    
    func setupBindings() {
        
        //Update the PrayerHeaderView
        eSolatViewModel
            .takwimSolatData
            .bind(onNext: {[weak self] (takwimSolatData) in
                self?.updateTakwimSolat(takwimSolatData)
            })
            .disposed(by: disposeBag)
        
        //Update Tomorrow prayer type and time after Isha for today
        eSolatViewModel
            .showTomorrowPrayerTime
            .bind(onNext: {[weak self] (prayerType, prayerTime, date) in
                self?.prayerTypeLabel.text = prayerType
                self?.prayerTimeLabel.text = prayerTime
                
                //TODO: Notification
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.scheduleLocalNotification(prayerType: prayerType, prayerTime: prayerTime)
                
                if let type = Utils.prayerNames[prayerType] {
                    self?.eSolatViewModel.fetchBGImageByPrayerTime(prayterType: type)
                }
                
                if !prayerTime.isEmpty {
                    self?.startTimerForNotifyPrayerTime(nextPrayerTime: prayerTime, dateString: date)
                    self?.eSolatViewModel.fetchBGImageByPrayerTime(prayterType: Utils.prayerNames[prayerType]!)
                }
            })
            .disposed(by: disposeBag)
        
        // Update TableView with Prayer Times, next and previous views
        eSolatViewModel
            .takwimSolatDataByPeriod
            .bind(onNext: { [weak self] (takwimSolatData) in
                if let prayerTime = takwimSolatData.prayerTime?.first {
                    self?.eSolatViewModel.currentSelectePrayerTimeInTable = prayerTime.date ?? ""
                    self?.islamicDateLabel.text = "\(prayerTime.date ?? "")\n\(prayerTime.day ?? "")"
                    if let prayerTimes = self?.eSolatViewModel.getPrayerTimeList(prayerTime) {
                        self?.eSolatViewModel.prayerTimes.onNext(prayerTimes)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        eSolatViewModel
            .prayerTimes
            .bind(to: prayerTableView.rx.items(cellIdentifier: "prayerTimeCell", cellType: PrayerTableViewCell.self)) {  (row,prayer,cell) in
                cell.update(prayerType: prayer.name, prayerTime: prayer.time)
            }
            .disposed(by: disposeBag)
        
        //To load bg images for prayer and zone
        eSolatViewModel
            .bgImagePrayerData
            .bind(onNext: {[weak self] (bgImageData) in
                self?.loadBackGroundImagesForPrayer(bgImageData: bgImageData)
            })
            .disposed(by: disposeBag)
        
        //To animate bg images for prayer
        eSolatViewModel
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
    }
    
}


//MARK: - Helper methods

extension PrayersViewController {
    
    private func updateTakwimSolat(_ takwimSolatData: TakwimSolatData) {
        if let prayerTime = takwimSolatData.prayerTime?.first {
            eDateLabel.text = Utils.getGregorianDate()
            iDateLabel.text = Utils.getHijriDate(prayerTime.hijri ?? "")
            nextPrayerTimeLabel.text = "Next Prayer Time"
            let nearPrayer = Utils.getNearestPrayerWith(prayerTime)
            
            eSolatViewModel.currentDisplayDate = prayerTime.date ?? ""
            
            if nearPrayer.prayerTime.isEmpty && nearPrayer.prayerType.isEmpty {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MMM-yyyy"
                var date = dateFormatter.string(from: Date())
                if  !eSolatViewModel.currentDisplayDate.isEmpty {
                    date = eSolatViewModel.currentDisplayDate
                }
                eSolatViewModel.fetchTakwimSolat(period: "date", date: Utils.getDateFormatForApiFromddMMMyyyy(dateString: date, type: .Next))
            } else {
                prayerTypeLabel.text = nearPrayer.prayerType
                prayerTimeLabel.text = nearPrayer.prayerTime
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.scheduleLocalNotification(prayerType: nearPrayer.prayerType, prayerTime: nearPrayer.prayerTime)
            }
            
            if let zoneKey = takwimSolatData.zone {
                zoneLabel.text = ZonesTableData.zoneValue(by: zoneKey)
//                zoneLabel.marquee()
            }
            
            islamicDateLabel.text = "\(prayerTime.date ?? "")\n\(prayerTime.day ?? "")"
            
            if !nearPrayer.prayerTime.isEmpty {
                startTimerForNotifyPrayerTime(nextPrayerTime: nearPrayer.prayerTime)
                eSolatViewModel.fetchBGImageByPrayerTime(prayterType: Utils.prayerNames[nearPrayer.prayerType]!)
            }
            
            eSolatViewModel.prayerTimes.onNext(eSolatViewModel.getPrayerTimeList(prayerTime))
            
            eSolatViewModel.currentSelectePrayerTimeInTable = prayerTime.date ?? ""
        }
    }
    
    private func loadBackGroundImagesForPrayer(bgImageData: BGImageByPrayerTimeData?) {
        if let bgImagesPrayerTime = bgImageData?.data {
            if let bg_images1 = bgImagesPrayerTime.bg_images1 {
                let imagePath = "\(Utils.baseUrl)\(bg_images1)"
                print(imagePath)
                self.prayerBGImageView.load(urlString: imagePath)
            } 
        }
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
            eSolatViewModel.fetchTakwimSolat()
        }
    }
}
