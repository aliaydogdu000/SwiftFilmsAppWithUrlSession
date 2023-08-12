//
//  Kategoriler.swift
//  FilmsApp
//
//  Created by Ali Aydoğdu on 5.02.2023.
//

import Foundation
class Kategoriler:Codable{
    var kategori_id:String?
    var kategori_ad:String?
    init(kategori_id: String? = nil, kategori_ad: String? = nil) {
        self.kategori_id = kategori_id
        self.kategori_ad = kategori_ad
    }
    init(){
        
    }
}
