//
//  ViewController.swift
//  PAN Teste
//
//  Created by Mac on 22/07/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentPage: UInt = 0
    let gameViewModel: GameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Config collection view
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: "GameCell")
        self.collectionView.refreshControl = UIRefreshControl()
        self.collectionView.refreshControl?.addTarget(self, action: #selector(refreshGames), for: .valueChanged)
        self.collectionView.addInfiniteScroll { collecView in
            self.loadGames() {
                collecView.finishInfiniteScroll()
                self.collectionView.reloadData()
            }
        }
        
        // Load games
        self.collectionView.refreshControl?.beginRefreshing()
        loadGames(true) {
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGames(_ refresh: Bool = false, completion: @escaping () -> Void) {
        if refresh {
            self.currentPage = 0
        }
        
        self.gameViewModel.loadTopGames(refresh, limit: 10, offset: self.currentPage * 10) { error in
            if let error = error {
                SwiftMessageBarUtils.showMessage("Erro!", message: error.localizedDescription, type: .error)
            }
            self.currentPage += 1
            completion()
        }
    }

    @objc func refreshGames() {
        loadGames(true) {
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gameViewModel.countGames
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        let topGame = self.gameViewModel.getGame(at: indexPath.row)
        
        cell.game = topGame?.game
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2
        return CGSize(width: width, height: width)
    }
}
