//
//  TopGame.swift
//  PAN Teste
//
//  Created by Mac on 22/07/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import Foundation

struct TopGame: Codable {
    let channels: Int64?
    let viewers: Int64?
    let game: Game?
    
    init(from entity: TopGameEntity) {
        self.channels = entity.channels
        self.viewers = entity.viewers
        
        if let gameEntity = entity.game {
            self.game = Game(from: gameEntity)
        } else {
            self.game = nil
        }
    }
}
