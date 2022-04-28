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
//  ZonesTableData.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 14/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import Foundation
import RxDataSources


struct ZoneData {
    var key: String?
    var description: String?
}

struct ZoneSectionData{
    var header: String
    var items: [Item]
}

extension ZoneSectionData: SectionModelType {
    typealias Item = ZoneData
    
    init(original: ZoneSectionData, items: [Item]) {
        self = original
        self.items = items
    }
}

struct ZonesTableData {
    
    static func zoneSections()-> [ZoneSectionData] {
        var joharZoneDataItems = [ZoneData]()
        joharZoneDataItems.append(ZoneData(key: "JHR01", description: "Pulau Aur dan Pulau Pemanggil"))
        joharZoneDataItems.append(ZoneData(key: "JHR02", description: "Johor Bahru, Kota Tinggi, Mersing"))
        joharZoneDataItems.append(ZoneData(key: "JHR03", description: "Kluang, Pontian"))
        joharZoneDataItems.append(ZoneData(key: "JHR04", description: "Batu Pahat, Muar, Segamat, Gemas Johor"))
        
        var kedahZoneDataItems = [ZoneData]()
        kedahZoneDataItems.append(ZoneData(key: "KDH01", description: "Kota Setar, Kubang Pasu, Pokok Sena (Daerah Kecil)"))
        kedahZoneDataItems.append(ZoneData(key: "KDH02", description: "Kuala Muda, Yan, Pendang"))
        kedahZoneDataItems.append(ZoneData(key: "KDH03", description: "Padang Terap, Sik"))
        kedahZoneDataItems.append(ZoneData(key: "KDH04", description: "Baling"))
        kedahZoneDataItems.append(ZoneData(key: "KDH05", description: "Bandar Baharu, Kulim"))
        kedahZoneDataItems.append(ZoneData(key: "KDH06", description: "Langkawi"))
        kedahZoneDataItems.append(ZoneData(key: "KDH07", description: "Puncak Gunung Jerai"))
        
        var kelantanZoneDataItems = [ZoneData]()
        kelantanZoneDataItems.append(ZoneData(key: "KTN01", description: "K.Bharu, Bachok, Pasir Puteh"))
        kelantanZoneDataItems.append(ZoneData(key: "KTN01", description: "Tumpat, Pasir Mas, Tnh. Merah"))
        kelantanZoneDataItems.append(ZoneData(key: "KTN01", description: "Machang, Kuala Krai"))
        kelantanZoneDataItems.append(ZoneData(key: "KTN01", description: "Mukim Chiku"))
        kelantanZoneDataItems.append(ZoneData(key: "KTN03", description: "Jeli, Bertam"))
        kelantanZoneDataItems.append(ZoneData(key: "KTN03", description: "Gua Musang (Daerah Galas dan Bertam)"))
        
        
        var klZoneDataItems = [ZoneData]()
        klZoneDataItems.append(ZoneData(key: "WLY01", description: "Kuala Lumpur"))
        
        var labuanZoneDataItems = [ZoneData]()
        labuanZoneDataItems.append(ZoneData(key: "WLY02", description: "Labuan"))
        
        var melakaZoneDataItems = [ZoneData]()
        melakaZoneDataItems.append(ZoneData(key: "MLK01", description: "Bandar Melaka, Alor Gajah"))
        melakaZoneDataItems.append(ZoneData(key: "MLK01", description: "Jasin, Masjid Tanah"))
        melakaZoneDataItems.append(ZoneData(key: "MLK01", description: "Merlimau, Nyalas"))
        
        var negeriSembilanZoneDataItems = [ZoneData]()
        negeriSembilanZoneDataItems.append(ZoneData(key: "NGS01", description: "Jempol, Tampin"))
        negeriSembilanZoneDataItems.append(ZoneData(key: "NGS02", description: "Port Dickson, Seremban"))
        negeriSembilanZoneDataItems.append(ZoneData(key: "NGS02", description: "Kuala Pilah, Jelebu"))
        negeriSembilanZoneDataItems.append(ZoneData(key: "NGS02", description: "Rembau"))
        
        var pahangZoneDataItems = [ZoneData]()
        pahangZoneDataItems.append(ZoneData(key: "PHG01", description: "Pulau Tioman"))
        pahangZoneDataItems.append(ZoneData(key: "PHG02", description: "Kuantan, Pekan"))
        pahangZoneDataItems.append(ZoneData(key: "PHG02", description: "Rompin, Muadzam Shah"))
        pahangZoneDataItems.append(ZoneData(key: "PHG03", description: "Maran, Chenor"))
        pahangZoneDataItems.append(ZoneData(key: "PHG03", description: "Temerloh, Bera"))
        pahangZoneDataItems.append(ZoneData(key: "PHG03", description: "Jerantut"))
        pahangZoneDataItems.append(ZoneData(key: "PHG04", description: "Bentong, Raub, Kuala Lipis"))
        pahangZoneDataItems.append(ZoneData(key: "PHG05", description: "Genting Sempah"))
        pahangZoneDataItems.append(ZoneData(key: "PHG05", description: "Janda Baik, Bukit Tinggi"))
        pahangZoneDataItems.append(ZoneData(key: "PHG06", description: "Bukit Fraser, Genting Higlands"))
        pahangZoneDataItems.append(ZoneData(key: "PHG06", description: "Cameron Higlands"))
        
        var perakZoneDataItems = [ZoneData]()
        perakZoneDataItems.append(ZoneData(key: "PRK01", description: "Tapah, Slim River"))
        perakZoneDataItems.append(ZoneData(key: "PRK01", description: "Tanjung Malim"))
        perakZoneDataItems.append(ZoneData(key: "PRK02", description: "Ipoh, Batu Gajah"))
        perakZoneDataItems.append(ZoneData(key: "PRK02", description: "Kampar, Sg. Siput"))
        perakZoneDataItems.append(ZoneData(key: "PRK02", description: "Kuala Kangsar"))
        perakZoneDataItems.append(ZoneData(key: "PRK03", description: "Pengkalan Hulu, Grik, Lenggong"))
        perakZoneDataItems.append(ZoneData(key: "PRK04", description: "Temengor dan Belum"))
        perakZoneDataItems.append(ZoneData(key: "PRK05", description: "Teluk Intan, Bagan Datoh"))
        perakZoneDataItems.append(ZoneData(key: "PRK05", description: "Kg.Gajah, Sri Iskandar, Beruas"))
        perakZoneDataItems.append(ZoneData(key: "PRK05", description: "Parit, Lumut, Setiawan"))
        perakZoneDataItems.append(ZoneData(key: "PRK05", description: "Pulau Pangkor"))
        perakZoneDataItems.append(ZoneData(key: "PRK06", description: "Selama, Taiping, Bagan Serai"))
        perakZoneDataItems.append(ZoneData(key: "PRK06", description: "Parit Buntar"))
        perakZoneDataItems.append(ZoneData(key: "PRK07", description: "Bukit Larut"))
        
        var perlisZoneDataItems = [ZoneData]()
        perlisZoneDataItems.append(ZoneData(key: "PLS01", description: "Kangar, Padang Besar, Arau"))
        
        var pulauPinangZoneDataItems = [ZoneData]()
        pulauPinangZoneDataItems.append(ZoneData(key: "PNG01", description: "Pulau Pinang"))
        
        var putraJayaZoneDataItems = [ZoneData]()
        putraJayaZoneDataItems.append(ZoneData(key: "WLY01", description: "Putrajaya"))
        
        var sabahZoneDataItems = [ZoneData]()
        sabahZoneDataItems.append(ZoneData(key: "SBH01", description: "Sandakan, Bdr. Bkt. Garam"))
        sabahZoneDataItems.append(ZoneData(key: "SBH01", description: "Semawang, Temanggong, Tambisan"))
        sabahZoneDataItems.append(ZoneData(key: "SBH02", description: "Pinangah, Terusan"))
        sabahZoneDataItems.append(ZoneData(key: "SBH02", description: "Beluran, Kuamut, Telupit"))
        sabahZoneDataItems.append(ZoneData(key: "SBH03", description: "Lahad Datu, Kunak, Silabukan"))
        sabahZoneDataItems.append(ZoneData(key: "SBH03", description: "Tungku, Sahabat, Semporna"))
        sabahZoneDataItems.append(ZoneData(key: "SBH04", description: "Tawau, Balong"))
        sabahZoneDataItems.append(ZoneData(key: "SBH04", description: "Merotai, Kalabakan"))
        sabahZoneDataItems.append(ZoneData(key: "SBH05", description: "Kudat, Kota Marudu"))
        sabahZoneDataItems.append(ZoneData(key: "SBH05", description: "Pitas, Pulau Banggi"))
        sabahZoneDataItems.append(ZoneData(key: "SBH06", description: "Gunung Kinabalu"))
        sabahZoneDataItems.append(ZoneData(key: "SBH07", description: "Papar, Ranau, Kota Belud"))
        sabahZoneDataItems.append(ZoneData(key: "SBH07", description: "Tuaran, Penampang, Kota Kinabalu"))
        sabahZoneDataItems.append(ZoneData(key: "SBH08", description: "Pensiangan, Keningau"))
        sabahZoneDataItems.append(ZoneData(key: "SBH08", description: "Tambunan, Nabawan"))
        sabahZoneDataItems.append(ZoneData(key: "SBH09", description: "Sipitang, Membakut, Beaufort"))
        sabahZoneDataItems.append(ZoneData(key: "SBH09", description: "Kuala Penyu, Weston"))
        sabahZoneDataItems.append(ZoneData(key: "SBH09", description: "Tenom, Long Pa Sia"))
        
        var sarawakZoneDataItems = [ZoneData]()
        sarawakZoneDataItems.append(ZoneData(key: "SWK01", description: "Limbang, Sundar, Terusan, Lawas"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK02", description: "Niah, Belaga, Sibuti"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK02", description: "Miri, Bekenu, Marudi"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK03", description: "Song, Belingan, Sebauh"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK03", description: "Bintulu, Tatau, Kapit"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK04", description: "Igan, Kanowit, Sibu, Dalat, Oya"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK05", description: "Belawai, Matu, Daro"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK05", description: "Sarikei, Julau, Bitangor, Rajang"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK05", description: "Kudat, Kota Marudu"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK06", description: "Kabong, Lingga, Sri Aman"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK06", description: "Engkelili, Betong, Spaoh"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK06", description: "Pusa, Saratok, Roban, Debak"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK07", description: "Samarahan, Simunjan"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK07", description: "Serian, Sebuyau, Meludam"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK08", description: "Kuching, Bau, Lundu, Sematan"))
        sarawakZoneDataItems.append(ZoneData(key: "SWK09", description: "Zon Khas (Kampung Patarikan)"))
        
        var selangorZoneDataItems = [ZoneData]()
        selangorZoneDataItems.append(ZoneData(key: "SGR01", description: "Gombak, H.Selangor, Rawang"))
        selangorZoneDataItems.append(ZoneData(key: "SGR01", description: "H.Langat, Sepang"))
        selangorZoneDataItems.append(ZoneData(key: "SGR01", description: "Petaling,  S.Alam"))
        selangorZoneDataItems.append(ZoneData(key: "SGR02", description: "Sabak Bernam, Kuala Selangor"))
        selangorZoneDataItems.append(ZoneData(key: "SGR03", description: "Klang, Kuala Langat"))
        
        var terengganuZoneDataItems = [ZoneData]()
        terengganuZoneDataItems.append(ZoneData(key: "TRG01", description: "Kuala Terengganu, Marang"))
        terengganuZoneDataItems.append(ZoneData(key: "TRG02", description: "Besut, Setiu"))
        terengganuZoneDataItems.append(ZoneData(key: "TRG03", description: "Hulu Terengganu"))
        terengganuZoneDataItems.append(ZoneData(key: "TRG04", description: "Kemaman Dungun"))
        
        
        let sections = [
            ZoneSectionData(header: "JOHOR", items: joharZoneDataItems),
            ZoneSectionData(header: "KEDAH", items: kedahZoneDataItems),
            ZoneSectionData(header: "KELANTAN", items: kelantanZoneDataItems),
            ZoneSectionData(header: "KUALALUMPUR", items: klZoneDataItems),
            ZoneSectionData(header: "LABUAN", items: labuanZoneDataItems),
            ZoneSectionData(header: "MELAKA", items: melakaZoneDataItems),
            ZoneSectionData(header: "NEGERISEMBILAN", items: negeriSembilanZoneDataItems),
            ZoneSectionData(header: "PAHANG", items: pahangZoneDataItems),
            ZoneSectionData(header: "PERAK", items: perakZoneDataItems),
            ZoneSectionData(header: "PERLIS", items: perlisZoneDataItems),
            ZoneSectionData(header: "PULAUPINANG", items: pulauPinangZoneDataItems),
            ZoneSectionData(header: "PUTRAJAYA", items: putraJayaZoneDataItems),
            ZoneSectionData(header: "SABAH", items: sabahZoneDataItems),
            ZoneSectionData(header: "SARAWAK", items: sarawakZoneDataItems),
            ZoneSectionData(header: "SELANGOR", items: selangorZoneDataItems),
            ZoneSectionData(header: "TERENGGANU", items: terengganuZoneDataItems)
        ]
        
        return sections
    }
    
    static func section(by zoneKey: String)-> String {
        return zoneSections().filter { $0.items.contains(where: { $0.key == zoneKey }) }.first?.header ?? ""
    }
    
    static func zoneValue(by zoneKey: String)-> String {
        return zoneSections().map { $0.items }.joined().filter { $0.key == zoneKey }.first?.description ?? ""
    }
}


