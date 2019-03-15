//
//  CountriesCollectionViewController.swift
//  ReadPlist
//
//  Created by Stanislav Cherkasov on 3/6/19.
//  Copyright © 2019 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class CountriesController: UICollectionViewController {
  var coinStore = CoinStore()
  var selectedCountry: Country?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.coinStore.loadCoins()
      
    print(self.coinStore.coins)
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int
  {
    return self.coinStore.countries.count
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showCoins" {
      if let coinsController = segue.destination as? CoinsController,
        let cell = sender as? CountryCell,
        let indexPath = self.collectionView.indexPath(for: cell)
      {
        self.selectedCountry = self.coinStore.countries[indexPath.row]
        coinsController.selectedCountry = self.selectedCountry
        coinsController.coinStore = self.coinStore
      }
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "cell",
        for: indexPath) as! CountryCell
    
    cell.nameLabel.text = self.coinStore.countries[indexPath.row].name
    cell.thumb.image = UIImage(named: self.coinStore.countries[indexPath.row].flagImageName)
    
    return cell
  }
}
