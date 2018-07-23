//
//  Game.swift
//  PAN Teste
//
//  Created by Mac on 22/07/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import Foundation

struct Game: Codable {
    let id: Int64?
    let box: Box?
    let giantbombId: Int64?
    let logo: Box?
    let name: String?
    let popularity: Int64?
    
    init(from entity: GameEntity) {
        self.id = entity.id
        self.box = Box(large: nil, medium: entity.box, small: nil, template: nil)
        self.giantbombId = entity.giantbombId
        self.logo = Box(large: nil, medium: entity.logo, small: nil, template: nil)
        self.name = entity.name
        self.popularity = entity.popularity
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case box = "box"
        case giantbombId = "giantbomb_id"
        case logo = "logo"
        case name = "name"
        case popularity = "popularity"
    }
    
    static var endPoint: String {
        get {
            return "\(APIClient.baseUrl)/games"
        }
    }
}

// MARK: Methods
extension Game {
    static func getTopGames(limit: UInt, offset: UInt, onSuccess: @escaping (TopGamesModel?) -> Void, onFailure: @escaping (Error) -> Void) {
        APIClient.get("\(self.endPoint)/top?limit=\(limit)&offset=\(offset)", model: TopGamesModel.self, onSuccess: { result in
            onSuccess(result)
        }, onFailure: { error in
            onFailure(error)
        })
    }
}
