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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.coinStore.loadCoins()
    navigationController?.navigationBar.barTintColor = UIColor.black
      
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

      let coinsVC = segue.destination as! CoinsController
      let cell = sender as! CountryCell
      let indexPath = self.collectionView.indexPath(for: cell)
      let countryPost = self.coinStore.countries[(indexPath?.row)!] as Country
      coinsVC.selectedCountry = countryPost
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "cell",
        for: indexPath) as! CountryCell
    
    cell.nameLabel.text = self.coinStore.countries[indexPath.row].name
    let image = UIImage(named: self.coinStore.countries[indexPath.row].flagImageName)
    cell.thumb.image = image
    
    return cell
  }
}
