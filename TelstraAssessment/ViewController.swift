//
//  ViewController.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 23/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.minimumLineSpacing = 1
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        return layout
    }()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupView()
    }
    
    //MARK:- Internal Methods
    private func setupView(){
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        activateConstants()
    }
    
    private func activateConstants(){
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
    }
}
