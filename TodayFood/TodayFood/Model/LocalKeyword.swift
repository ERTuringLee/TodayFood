//
//  LocalKeyword.swift
//  TodayFood
//
//  Created by 이재문 on 2023/03/02.
//

import Foundation

struct LocalKeyword: Codable {
    var documents: [Document]
    
    struct Document: Codable {
        var place_name: String
        var place_url: String
        var road_address_name: String
        var x: String
        var y: String
    }
}
