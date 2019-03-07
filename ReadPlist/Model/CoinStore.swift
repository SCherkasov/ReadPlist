//
//  CoinStore.swift
//  ReadPlist
//
//  Created by Ievgen Gavrysh on 3/7/19.
//  Copyright © 2019 Stanislav Cherkasov. All rights reserved.
//

import Foundation

class CoinStore {
  
  var coins = [Coin]()
  var countries = [Country]()
  
  func loadCoins() {
    var countries = [Country]()
    var coins = [Coin]()
    
    if let path = Bundle.main.path(forResource: "My",
                                   ofType: "plist"),
      let data = FileManager.default.contents(atPath: path),
      let unserialized = try? PropertyListSerialization.propertyList(
        from: data,
        options:.mutableContainersAndLeaves,
        format:nil),
      let dict = unserialized as? [String: Any],
      let countriesDict = dict["Countries"] as? [[String: Any]]
    {
      for countryDict in countriesDict {
        if let countryName = countryDict["name"] as? String,
          let countryFlagImageName = countryDict["flagImageName"] as? String,
          let countryCoinsD = countryDict["Coins"] as? [[String: String]]
        {
          let country = Country.init(name: countryName, flagImageName:
            countryFlagImageName)
          countries.append(country)
          
          var countryCoins = [Coin]()
          
          for coinDict in countryCoinsD {
            if let name = coinDict["name"],
              let image = coinDict["image"]
            {
              countryCoins.append(Coin.init(name: name, image: image, country: country))
            }
          }
          
          coins = coins + countryCoins
        }
      }
    }
    
    self.coins = coins
    self.countries = countries
  }
}

