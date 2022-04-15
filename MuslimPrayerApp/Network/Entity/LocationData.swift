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
//  LocationData.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 05/04/2022.
//

import Foundation

struct MosqueLocations: Codable {
    var lat: String?
    var long: String?
    var distance: String?
    var locationData: [LocationData]?
}

struct LocationData: Codable {
    var esolat_sismim_id: String?
    var no_daftar: String?
    var no_daftar_num: String?
    var sequent_id: String?
    var nama_masjid: String?
    var alamat: String?
    var poskod: String?
    var id_negeri: String?
    var id_jenis: String?
    var id_daerah: String?
    var id_kariah: String?
    var id_masjid_old: String?
    var takmir: String?
    var chk_warisan: String?
    var chk_pelancongan: String?
    var chk_luarnegara: String?
    var chk_khairuljamek: String?
    var tel: String?
    var fax: String?
    var bank: String?
    var no_akaun: String?
    var email: String?
    var url_website: String?
    var id_lama: String?
    var no_daftar_surau_lama: String?
    var kod_parlimen: String?
    var id_dun: String?
    var dt_bina: String?
    var sejarah: String?
    var binaan: String?
    var kemudahan: String?
    var istimewa: String?
    var lokasi: String?
    var latitud: String?
    var longitud: String?
    var rasmi: String?
    var dt_rasmi: String?
    var kapasiti: String?
    var luas_tanah: String?
    var kos: String?
    var kos_federal: String?
    var kos_state: String?
    var kos_sumbang: String?
    var img_name: String?
    var img_descr: String?
    var kelas_takmir: String?
    var id_masjid: String?
    var distance: String
}
