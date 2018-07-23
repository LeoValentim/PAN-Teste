//
//  GameCell.swift
//  PAN Teste
//
//  Created by Mac on 22/07/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {

    @IBOutlet weak var photoImage: ImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    var game: Game? {
        didSet {
            if let url = game?.box?.medium {
                self.photoImage?.loadAndCacheImage(from: url)
            }
            self.nameLabel?.text = game?.name
            self.popularityLabel?.text = "Popularidade: \(game?.popularity ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
