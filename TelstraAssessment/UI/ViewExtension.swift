//
//  ViewExtension.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 23/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

protocol ViewControllerProtocol {
    
    func showList(title:String, rows:[ServiceListObject])
    func showError(message:String)
}

extension ViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CollectionViewCell
        cell.resetCellElements()
        if let listObject = self.listData{
         
            cell.setOject(listObject: listObject[indexPath.item])
        }
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

extension ViewController : ViewControllerProtocol{
    
    func showList(title: String, rows: [ServiceListObject]) {
        
        self.listData = rows
        self.title = title
        self.collectionView.reloadData()
    }
    
    func showError(message: String) {
        
        self.title = ""
        self.navigationController?.present(CommonUtilities.showAlert(message: message), animated: true, completion: nil)
    }
}
