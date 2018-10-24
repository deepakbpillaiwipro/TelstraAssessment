//
//  ViewExtension.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 23/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit
import Kingfisher

extension ViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CollectionViewCell
        //Resetting reused cells
        cell.titleLabel.text = ""
        cell.descriptionLabel.text = ""
        cell.imageView.image = nil
        
        //Assign Values
        cell.titleLabel.text = "Title"
        cell.descriptionLabel.text = "Description  weihf iwe fiw efi bweb fyw ef iwyef ihw fiyw efu iuw fou wieu fvwou efiu9w eu weuif wije fiuwe fijew fiub we"
        cell.imageView.image = UIImage.init(named: "placeholder")
        //cell.imageView.kf.setImage(with: )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: calculateCellWidth(for: collectionView, section: indexPath.section), height: 60)
    }
    
    //MARK:- Helper Method
    fileprivate func calculateCellWidth(for collectionView: UICollectionView, section: Int) -> CGFloat {
        
        return collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
    }
}
