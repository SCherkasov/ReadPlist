//
//  CoinsCollectionViewController.swift
//  ReadPlist
//
//  Created by Stanislav Cherkasov on 3/6/19.
//  Copyright © 2019 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class CoinsCollectionViewController: UICollectionViewController {
  
  var coins: [Coin] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    
    return coins.count
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                  for: indexPath) as! CoinsCollectionViewCell
    
    cell.nameLabel.text = coins[indexPath.row].name
    cell.thumb.image = UIImage(named: coins[indexPath.row].image)
    
    return cell
  }
}
