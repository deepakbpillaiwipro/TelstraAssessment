//
//  CollectionViewCell.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 23/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    private lazy var width: NSLayoutConstraint = {
        
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.init(named: "placeholder")
        return imageView
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init coder is required")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    //MARK:- Internal Methods
    fileprivate func setupView() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
        activateConstants()
    }
    
    fileprivate func activateConstants(){
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            descriptionLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            contentView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 5)
        ])
    }
    
    func resetCellElements(){
        
        //Resetting reused cells
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.imageView.image = UIImage.init(named: Constants.ApplicationConstants.placeholderImage)
    }
    func setOject(listObject:ServiceListObject){
        
        //Assign Values
        self.titleLabel.text = listObject.titleString
        self.descriptionLabel.text = listObject.descriptionString
        if let imageUrl = listObject.imageLinkStrig{
            
            self.imageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named:Constants.ApplicationConstants.placeholderImage), options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: nil)
        }
    }
}
