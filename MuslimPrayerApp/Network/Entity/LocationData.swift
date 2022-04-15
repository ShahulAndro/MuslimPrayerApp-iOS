//
//  LocationData.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 05/04/2022.
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
