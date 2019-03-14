//
//  CoinsCollectionViewController.swift
//  ReadPlist
//
//  Created by Stanislav Cherkasov on 3/6/19.
//  Copyright © 2019 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class CoinsController: UICollectionViewController {
  
  var coinStore = CoinStore()
  var selectedCountry: Country?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.coinStore.loadCoins()
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int
  {
    return self.coinStore.coins.count
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                  for: indexPath) as! CoinCell

    cell.nameLabel.text = self.coinStore.coins[indexPath.row].name
    cell.thumb.image = UIImage(named: self.coinStore.coins[indexPath.row].image)
    
    return cell
  }
}
