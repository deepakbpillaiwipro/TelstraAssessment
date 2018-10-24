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
    
    lazy var refreshControl:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .blue
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        return refreshControl
    }()
    
    var interactor:ViewInteractorProtocol?
    var listData:[ServiceListObject]?
    
    //MARK:- View Lifecycle
    func setup(){
        
        let viewcontroller = self
        let interactor = ViewInteractor()
        let presenter = ViewPresenter()
        
        interactor.presenter = presenter
        presenter.viewController = viewcontroller
        viewcontroller.interactor = interactor
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setupView()
        loadData()
    }
    
    //MARK:- Internal Methods
    private func loadData(){
        
        self.interactor?.getListOfData()
    }
    private func setupView(){
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        activateConstants()
        collectionView.addSubview(refreshControl)
    }

    private func activateConstants(){
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
    }
    
    @objc private func refresh(){
        
        loadData()
        refreshControl.endRefreshing()
    }
}
