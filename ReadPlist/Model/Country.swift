//
//  Country.swift
//  ReadPlist
//
//  Created by Ievgen Gavrysh on 3/7/19.
//  Copyright © 2019 Stanislav Cherkasov. All rights reserved.
//

import Foundation

struct Country: Equatable {
  var name: String
  var flagImageName: String
  
  static func==(lhs: Country, rhs: Country) -> Bool {
    return lhs.name == rhs.name && lhs.flagImageName == rhs.flagImageName
  }
}
