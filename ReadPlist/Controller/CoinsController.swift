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
    self.coinStore.filterCoins(with: selectedCountry!)
    self.addFlagToHeader()
    navigationController?.navigationBar.barTintColor = UIColor.black
    
  }
  
  // MARK: Private
  // https://stackoverflow.com/questions/38548397/ios-add-image-and-text-in-title-of-navigation-bar
  private func addFlagToHeader() {
    if self.navigationController == nil {
      return
    }
    
    // Create a navView to add to the navigation bar
    let navView = UIView()
    
    // Create the label
    let label = UILabel()
    label.text = selectedCountry?.name
    label.sizeToFit()
    label.center = navView.center
    label.textAlignment = NSTextAlignment.center
    label.textColor = UIColor.init(
      red: 255.0 / 255.0,
      green: 215.0 / 255.0,
      blue: 0.0,
      alpha: 1.0)
    
    // Create the image view
    let image = UIImageView()
    image.image = UIImage(named: (selectedCountry?.flagImageName)!)
    // To maintain the image's aspect ratio:
    let imageAspect = image.image!.size.width / image.image!.size.height
    // Setting the image frame so that it's immediately before the text:
    image.frame = CGRect(x: label.frame.origin.x - label.frame.size.height * imageAspect - 3,
                         y: label.frame.origin.y,
                         width: label.frame.size.height * imageAspect,
                         height: label.frame.size.height)
    
    image.contentMode = UIView.ContentMode.scaleAspectFit
    
    // Add both the label and image view to the navView
    navView.addSubview(label)
    navView.addSubview(image)
    
    // Set the navigation bar's navigation item's titleView to the navView
    self.navigationItem.titleView = navView
    
    // Set the navView's frame to fit within the titleView
    navView.sizeToFit()
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
    let image = UIImage(named: self.coinStore.coins[indexPath.row].image)
    cell.thumb.image = image?.imageByMakingWhiteBackgroundTransparent()

    return cell
  }
}
