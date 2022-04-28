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
//  DataManager.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 16/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import Foundation

struct DataManager {
    
    static func getTakwimSolatData()-> TakwimSolatData {
        
        var prayerTimes = [TakwimSolat]()
        
        var takwimSolat = TakwimSolat()
        takwimSolat.hijri = "1443-08-26"
        takwimSolat.date = "9-Mar-2022"
        takwimSolat.day = "Tuesday"
        takwimSolat.imsak = "05:57:00"
        takwimSolat.fajr = "06:07:00"
        takwimSolat.syuruk = "07:13:00"
        takwimSolat.dhuhr = "13:21:00"
        takwimSolat.asr = "16:21:00"
        takwimSolat.maghrib = "19:24:00"
        takwimSolat.isha = "20:33:00"
        prayerTimes.append(takwimSolat)
        
        var solatData = TakwimSolatData()
        solatData.prayerTime = prayerTimes
        
        return solatData
    }
    
    static func getBgImageByPrayertimeData()-> BGImageByPrayerTimeData {
        
        var imgPrayer = BGImageByPrayerTime()
        imgPrayer.bg_id = "1"
        imgPrayer.bg_set = "Zohor"
        imgPrayer.bg_images1 = "/portalassets/images/background/pathway-middle-green-leafed-trees-with-sun-shining-through-branches-min.jpg"
        imgPrayer.bg_images2 = "/portalassets/images/background/mesmerizing-view-fields-near-ocean-during-sunrise (1)-min (2).jpg"
        imgPrayer.bg_images3 = "/portalassets/images/background/imejlatar6.jpg"
        imgPrayer.bg_images4 = "/portalassets/images/background/imejlatar3.jpg"
        imgPrayer.bg_images5 = "/portalassets/images/background/seedling-new-baby-forest-spring-min.jpg"
        
        var data = BGImageByPrayerTimeData()
        data.data = imgPrayer
        
        return data
    }
    
    static func getNearestMosquesData()-> MosqueLocations {
        var location1 = LocationData()
        
        location1.esolat_sismim_id = "7329"
        location1.no_daftar = "MY-14-WKL-00001"
        location1.no_daftar_num = "458-1400-1-00001"
        location1.sequent_id = "1"
        location1.nama_masjid = "MASJID NEGARA"
        location1.alamat = "JALAN PERDANA"
        location1.poskod = "50480"
        location1.id_negeri = "14"
        location1.id_jenis = "01"
        location1.id_daerah = "1400"
        location1.id_kariah = ""
        location1.id_masjid_old = ""
        location1.takmir = ""
        location1.chk_warisan = "0"
        location1.chk_pelancongan = "1"
        location1.chk_luarnegara = "0"
        location1.chk_khairuljamek = "0"
        location1.tel = "03-26937784"
        location1.fax = "03-26913696"
        location1.bank = ""
        location1.no_akaun = ""
        location1.email = ""
        location1.url_website = ""
        location1.id_lama = ""
        location1.no_daftar_surau_lama = ""
        location1.kod_parlimen = ""
        location1.id_dun = "0"
        location1.dt_bina = "1965-08-27"
        location1.sejarah = "Masjid Negara dibina sebagai tanda kesyukuran pemimpin dan rakyat atas kemerdekaan Tanah Melayu yang telah dicapai tanpa peperangan. Pembinaan masjid ini adalah atas cadangan Almarhum YTM Tunku Abdul Rahman Putra Al-Haj, Perdana Menteri Malaysia yang pertama. Ia menjadi lambang semangat perpaduan dan toleransi rakyat kerana melibatkan semua kaum pada ketika itu. Ini kerana selain daripada peruntukan wang kerajaan, kos pembiayaan membina Masjid Negara disumbangkan oleh rakyat jelata tanpa mengira kaum, agama dan bangsa. Nama masjid ini telah diberikan oleh YTM Tunku Abdul Rahman. Beliau tidak bersetuju masjid ini dinamakan dengan nama beliau seperti yang telah dicadangkan oleh banyak pihak.\r\n\r\nMasjid Negara telah siap dibina pada 27 Ogos 1965 dan menjadi lambang keagongan Islam di Malaysia. Ia boleh menampung seramai 15,000 jemaah."
        location1.binaan = "Keseluruhan reka bentuk seni bina Masjid Negara ini bercirikan reka bentuk tempatan dan moden. Pereka bentuknya cuba mengalih kelaziman reka bentuk masjid dari konsep seni bina Arab dan Moghul yang berkubah separuh bulat dan berbentuk bawang seperti kebanyakan masjid terdahulu.\r\n\r\nCiri Masjid Negara turut mengaplikasikan seni bina Melayu tradisi yang mementingkan reka bentuk yang disesuaikan dengan keadaan cuaca dan sosio budaya masyarakat tempatan. Bahagian bumbung yang menjadi identiti utamanya berkonsepkan payung terbuka. Konsep payung yang menjadi kubah kepada Masjid Negara ini melambangkan semangat dan kedaulatan raja yang memayungi negara dan berpegang kepada prinsip Islam sebagai agama rasmi Persekutuan.\r\n\r\nKeunikan reka bentuk bumbung masjid ini telah menjadi ikutan dalam pembinaan masjid-masjid lain, antaranya Masjid Ahmad Ibrahim dan Masjid Kampung Raja di Terengganu."
        location1.kemudahan = "Ruang anjung dan serambi yang luas di masjid ini dapat menampung kebanjiran para jemaah pada masa solat Jumaat dan solat hari raya. Selain itu ia turut digunakan untuk acara-acara lain seperti pameran majlis berbuka puasa dan sebagainya. Terdapat juga kemudahan lain di masjid ini seperti bangunan pentadbiran, perpustakaan, pejabat imam dan bilal, bilik orang kenamaan, dewan syarahan dan juga Makam Pahlawan.\r\n\r\nMendekati konsep seni bina Islam, Masjid Negara turut dilengkapi dengan pokok-pokok hijau dan beberapa kolam air dan air pancutan yang bertujuan mengimbangi udara di persekitaran dan mengindahkan kawasan masjid.\r\n\r\nFungsi masjid tidak bertumpu kepada ibadah solat semata-mata. Kegiatan-kegiatan lain seperti pendidikan, ceramah dan muzakarah diadakan untuk semua lapisan masyarakat. Menurut pegawai masjid ini ada antara mereka yang pernah melawat masjid ini mendapat hidayah daripada Allah lalu memeluk Islam setelah teruja dengan keindahannya."
        location1.istimewa = "Terdapat beberapa komponen lain yang menarik di Masjid Negara. Menaranya berkubahkan bentuk payung sedang menguncup. Warna biru menjadi pilihan dan menara ini dilengkapi dengan kemudahan lif untuk turun dan naik.\r\n\r\nJika di bahagian luar kita dapat melihat menaranya, di bahagian dalam masjid ini terutama di dewan solat utamanya tersergam indah mimbar yang diperbuat sepenuhnya daripada kayu yang diukir bermotifkan bunga. Terdapat sebuah tangga berlapikkan karpet baldu tanpa corak sebagai penyeri. Mihrab masjid ini pula dihiasi dengan ukiran-ukiran bermotifkan geometri, bunga dan ukiran muqarnas yang sangat menarik.\r\n\r\nAntara hiasan lain yang menjadi tarikan di masjid ini ialah tulisan khat yang menghiasi dinding sebelah hadapan dewan solat utama. Lampu-lampu kristal pula memberi cahaya dan menambah seri ruang ini. Selain itu cermin kaca berwarna turut memberi impak warna warni dan meningkatkan lagi kegemerlapan dan keindahan sebuah dewan solat."
        location1.lokasi = "Masjid Negara ini dibina di atas sebidang tanah berkeluasan 5.46 hektar. Kedudukannya bertentangan dengan stesen keretapi Kuala Lumpur. Berhampiran dengan bangunan ini juga, terdiri Kompleks Pusat Islam dan Muzium Kesenian Islam. Lokasinya sangat strategik dilengkapi dengan berbagai-bagai kemudahan dan berdekatan pula dengan stesen pengangkutan awam. "
        location1.latitud = "3.141812"
        location1.longitud = "101.691695"
        location1.rasmi = "SERI PADUKA BAGINDA YANG DIPERTUAN AGONG"
        location1.dt_rasmi = "1970-01-01"
        location1.kapasiti = "15000"
        location1.luas_tanah = "13.00"
        location1.kos = "10000000"
        location1.kos_federal = "40500000.00"
        location1.kos_state = "20500000.00"
        location1.kos_sumbang = "3000000.00"
        location1.img_name = "2-masjid_negara4.jpg"
        location1.img_descr = ""
        location1.kelas_takmir = ""
        location1.id_masjid = "1"
        location1.distance = "1.0524383719570438"
        
        var locations = [LocationData]()
        locations.append(location1)
        
        var mosqueLocations = MosqueLocations()
        mosqueLocations.locationData = locations
        
        return mosqueLocations
    }
    
    static func getTakwimSolatDataWithHttpResponse()-> (response: HTTPURLResponse, data: TakwimSolatData) {
        
        let response = HTTPURLResponse(url: URL(string: "http://anyurl.com")!, statusCode: 200, httpVersion: "", headerFields: nil)
        
        var prayerTimes = [TakwimSolat]()
        
        var takwimSolat = TakwimSolat()
        takwimSolat.hijri = "1443-08-26"
        takwimSolat.date = "9-Mar-2022"
        takwimSolat.day = "Tuesday"
        takwimSolat.imsak = "05:57:00"
        takwimSolat.fajr = "06:07:00"
        takwimSolat.syuruk = "07:13:00"
        takwimSolat.dhuhr = "13:21:00"
        takwimSolat.asr = "16:21:00"
        takwimSolat.maghrib = "19:24:00"
        takwimSolat.isha = "20:33:00"
        prayerTimes.append(takwimSolat)
        
        var solatData = TakwimSolatData()
        solatData.prayerTime = prayerTimes
        
        return (response!, solatData)
    }
}
