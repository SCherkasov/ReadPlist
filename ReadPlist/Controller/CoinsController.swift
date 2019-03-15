//
//  CoinsCollectionViewController.swift
//  ReadPlist
//
//  Created by Stanislav Cherkasov on 3/6/19.
//  Copyright © 2019 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class CoinsController: UICollectionViewController {
  
  var coinStore: CoinStore?
  
  var selectedCountry: Country?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let unwrappedStore = self.coinStore,
      let unwrappedSelectedCountry = self.selectedCountry
    {
      unwrappedStore.filterCoins(for: unwrappedSelectedCountry)
    }
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int
  {
    return self.coinStore?.coins.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                  for: indexPath) as! CoinCell
    if let unwrappedStore = self.coinStore {
      cell.nameLabel.text = unwrappedStore.coins[indexPath.row].name
      cell.thumb.image = UIImage(named: unwrappedStore.coins[indexPath.row].image)
    } else {
      cell.nameLabel.text = "No Coin Storage"
      cell.thumb.image = UIImage(named: "no-coin")
    }
    
    return cell
  }
}
