//
//  GameViewModel.swift
//  PAN Teste
//
//  Created by Mac on 22/07/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import Foundation

class GameViewModel: NSObject {
    
    private var topGames: [TopGame] = []
    var countGames: Int {
        get {
            return self.topGames.count
        }
    }
    
    func loadTopGames(_ refresh: Bool = false, limit: UInt, offset: UInt, completion: @escaping (Error?) -> Void) {
        if refresh {
            self.topGames = []
        }
        
        Game.getTopGames(limit: limit, offset: offset, onSuccess: { result in
            let newGames = result?.top ?? []
            self.topGames += newGames
            
            completion(nil)
            
            // Save Games offline
            _ = TopGameEntity.saveChanges(changes: { managedObjectContext in
                var base = TopGameEntity.ToList(managedObjectContext)
                
                if refresh {
                    base.forEach({ item in
                        managedObjectContext.delete(item)
                    })
                    base.removeAll()
                }
                
                self.topGames.forEach({ topGame in
                    if !base.contains(where: { $0.game?.id == topGame.game?.id }) {
                        let gameEntity = GameEntity(entity: GameEntity.entity(), insertInto: managedObjectContext)
                        gameEntity.setValue(topGame.game?.logo?.medium, forKey: "logo")
                        gameEntity.setValue(topGame.game?.box?.medium, forKey: "box")
                        gameEntity.setValue(topGame.game?.giantbombId, forKey: "giantbombId")
                        gameEntity.setValue(topGame.game?.id, forKey: "id")
                        gameEntity.setValue(topGame.game?.name, forKey: "name")
                        gameEntity.setValue(topGame.game?.popularity, forKey: "popularity")
                        
                        let topGameEntity = TopGameEntity(entity: TopGameEntity.entity(), insertInto: managedObjectContext)
                        topGameEntity.setValue(gameEntity, forKey: "game")
                        
                        base.append(topGameEntity)
                    }
                })
            })
        }, onFailure: { error in
            print("erro load games")
            print("error: \(error)")
            
            if let managedObjectContext = TopGameEntity.managedContext  {
                let base = TopGameEntity.ToList(managedObjectContext)
                self.topGames = base.map({ return TopGame(from: $0) })
                
                completion(error)
            }
        })
    }
    
    func getGame(at index: Int) -> TopGame? {
        guard self.topGames.indices.contains(index) else { return nil }
        return self.topGames[index]
    }
}
