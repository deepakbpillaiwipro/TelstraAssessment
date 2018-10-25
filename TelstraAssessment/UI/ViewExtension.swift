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

extension ViewController:ViewControllerProtocol, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.listData?.count ?? 0
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

extension ViewControllerProtocol where Self:ViewController{
    
    func showList(title: String, rows: [ServiceListObject]) {
        
        //Alert if no rows from in the response 
        if rows.count == 0 {
            
           self.navigationController?.present(CommonUtilities.showAlert(message: Constants.ApplicationConstants.noRecordErrorString), animated: true, completion: nil)
            return
        }
        self.listData = rows
        self.title = title
        self.collectionView.reloadData()
    }
    
    func showError(message: String) {
        
        DispatchQueue.main.async {
            
            self.title = ""
            self.listData = nil
            self.collectionView.reloadData()
            self.refreshControl.isHidden = true
        }
        self.navigationController?.present(CommonUtilities.showAlert(message: message), animated: true, completion: nil)
        self.refreshControl.isHidden = false
    }
}
