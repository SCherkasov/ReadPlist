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
            let country = Country.init(name: countryName, flagImageName: countryFlagImageName)
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return countries.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
    
      cell.nameLabel.text = countries[indexPath.row].name
      cell.thumb.image = UIImage(named: countries[indexPath.row].flagImageName)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
