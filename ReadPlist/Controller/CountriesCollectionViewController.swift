//
//  CountriesCollectionViewController.swift
//  ReadPlist
//
//  Created by Stanislav Cherkasov on 3/6/19.
//  Copyright © 2019 Stanislav Cherkasov. All rights reserved.
//

import UIKit

struct Coin {
  var name: String
  var image: String
  var country: Country
}

struct Country {
  var name: String
  var flagImageName: String
}

class CountriesCollectionViewController: UICollectionViewController {
  
  var coins: [Coin] = []
  var countries: [Country] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let path = Bundle.main.path(forResource: "My",
                                   ofType: "plist"),
      let data = FileManager.default.contents(atPath: path),
      let unserialized
      = try? PropertyListSerialization.propertyList(
        from: data,
        options:.mutableContainersAndLeaves,
        format:nil),
      let dict = unserialized as? [String: Any],
      let countriesDict = dict["Countries"] as? [[String: Any]]
    {
      
      countriesDict.map { (countryDict: [String: Any]) in
        if let countryName = countryDict["name"] as? String,
          let countryFlagImageName = countryDict["flagImageName"] as? String,
          let countryCoinsD = countryDict["Coins"] as? [[String: String]]
        {
          let country = Country.init(name: countryName, flagImageName:
            countryFlagImageName)
          countries.append(country)
          
          coins = coins +
            countryCoinsD.compactMap { (coinDict: [String: String]) -> Coin? in
              if let name = coinDict["name"],
                let image = coinDict["image"]
              {
                return Coin.init(name: name, image: image, country: country)
              }
              
              return nil
          }
        }
      }
      
      print(coins)
    }
    
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    
    return countries.count
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                              for: indexPath) as! CountriesCollectionViewCell
    
    cell.nameLabel.text = countries[indexPath.row].name
    cell.thumb.image = UIImage(named: countries[indexPath.row].flagImageName)
    
    return cell
  }
}
