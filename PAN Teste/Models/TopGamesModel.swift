//
//  TopGamesModel.swift
//  PAN Teste
//
//  Created by Mac on 22/07/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import Foundation

struct TopGamesModel: Codable {
    let total: Int?
    let top: [TopGame]?
    
    enum CodingKeys: String, CodingKey {
        case total = "_total"
        case top = "top"
    }
}
