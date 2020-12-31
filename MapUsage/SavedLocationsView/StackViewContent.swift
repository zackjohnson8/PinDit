//
//  StackViewContent.swift
//  MapUsage
//
//  Created by Zachary Johnson on 10/12/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StackViewContent: UIStackView
{
    private lazy var titleString:String? = nil
    private lazy var descriptionString:String? = nil
    private lazy var imageString:String? = nil
    private lazy var parentStackView:UIStackView? = nil
    private lazy var pinLocation:PinLocation? = nil
    
    private lazy var imageView:UIImageView = {
        var imageView:UIImageView = UIImageView.init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel:UILabel = {
        var titleLabel:UILabel = UILabel.init()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Helvetica Neue Bold", size: 16.0)
        return titleLabel
    }()
    
    private lazy var descriptionLabel:UILabel = {
        var descriptionLabel:UILabel = UILabel.init()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .systemGray
        descriptionLabel.font = UIFont(name: "Helvetica Neue", size: 14.0)
        descriptionLabel.numberOfLines = 3
        descriptionLabel.sizeToFit()
        return descriptionLabel
    }()
    
    private lazy var descriptionUIView:UIView = {
        var descriptionUIView: UIView = UIView.init()
        descriptionUIView.translatesAutoresizingMaskIntoConstraints = false
        descriptionUIView.sizeToFit()
        return descriptionUIView
    }()
    
    // description and title stackView
    private lazy var verticalStackView:UIStackView = {
        var stackView:UIStackView = UIStackView.init()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var deleteUIView:UIView = {
        var deleteView: UIView = UIView.init()
        deleteView.translatesAutoresizingMaskIntoConstraints = false
        return deleteView
    }()
    
    private lazy var imageViewDelete:UIImageView = {
        var imageViewDelete:UIImageView = UIImageView.init()
        imageViewDelete.translatesAutoresizingMaskIntoConstraints = false
        imageViewDelete.layer.masksToBounds = true
        return imageViewDelete
    }()
    
    private var deleteWidthConstraint:NSLayoutConstraint!
    private var deleteImageWidthConstraint:NSLayoutConstraint!
    private var deleteImageHeightConstraint:NSLayoutConstraint!
    private var selfHeightConstraint:NSLayoutConstraint!
    private var selfWidthConstraint:NSLayoutConstraint!
    
    public func initialize(parent: UIStackView, pinLocation: PinLocation, image: String)
    {
        parentStackView = parent
        titleString = pinLocation.title
        descriptionString = pinLocation.subtitle
        imageString = image
        self.pinLocation = pinLocation
        
        setConstraints()
        setupImage()
        setupVerticalStack()
        setupTitle()
        setupDescription()
        setupDelete()
        
        self.alignment = .center
        self.axis = .horizontal
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    
    
    public func getTitleString() -> String
    {
        return titleString!
    }
    
    public func getDescriptionString() -> String
    {
        return descriptionString!
    }
    
    public func getImageString() -> String
    {
        return imageString!
    }
    
    public func handleSwipe(_ sender: UISwipeGestureRecognizer)
    {
        if(sender.direction == UISwipeGestureRecognizer.Direction.left)
        {
            deleteWidthConstraint.isActive = false
            deleteWidthConstraint = deleteUIView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0)
            deleteWidthConstraint.isActive = true
            
            deleteImageWidthConstraint.isActive = false
            deleteImageHeightConstraint.isActive = false
            deleteImageWidthConstraint = imageViewDelete.widthAnchor.constraint(equalTo: deleteUIView.widthAnchor, multiplier: 0.3)
            deleteImageHeightConstraint = imageViewDelete.heightAnchor.constraint(equalTo: deleteUIView.heightAnchor, multiplier: 0.3)
            deleteImageWidthConstraint.isActive = true
            deleteImageHeightConstraint.isActive = true
            return
        }
        
        if(sender.direction == UISwipeGestureRecognizer.Direction.right)
        {
            deleteWidthConstraint.isActive = false
            deleteWidthConstraint = deleteUIView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.0)
            deleteWidthConstraint.isActive = true
            
            deleteImageWidthConstraint.isActive = false
            deleteImageHeightConstraint.isActive = false
            deleteImageWidthConstraint = imageViewDelete.widthAnchor.constraint(equalTo: deleteUIView.widthAnchor, multiplier: 0.0)
            deleteImageHeightConstraint = imageViewDelete.heightAnchor.constraint(equalTo: deleteUIView.heightAnchor, multiplier: 0.0)
            deleteImageWidthConstraint.isActive = true
            deleteImageHeightConstraint.isActive = true
            return
        }
    }
    
    private func setConstraints()
    {
        selfHeightConstraint = self.heightAnchor.constraint(equalToConstant: 125.0)
        selfWidthConstraint = self.widthAnchor.constraint(equalTo: parentStackView!.widthAnchor, multiplier: 0.92)
        selfHeightConstraint.isActive = true
        selfWidthConstraint.isActive = true
    }
    
    private func setupImage()
    {
        self.addArrangedSubview(imageView)
        imageView.image = UIImage(named: imageString!)
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupVerticalStack()
    {
        self.addArrangedSubview(verticalStackView)
        verticalStackView.sizeToFit()
        verticalStackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        verticalStackView.spacing = 5
        verticalStackView.isLayoutMarginsRelativeArrangement = true
        verticalStackView.layoutMargins = UIEdgeInsets(top: 20, left: 7, bottom: 20, right: 7)
    }
    
    private func setupTitle()
    {
        verticalStackView.addArrangedSubview(titleLabel)
        titleLabel.text = titleString
    }
    
    private func setupDescription()
    {
        verticalStackView.addArrangedSubview(descriptionUIView)
        descriptionUIView.addSubview(descriptionLabel)
        descriptionLabel.widthAnchor.constraint(equalTo: descriptionUIView.widthAnchor).isActive = true
        descriptionLabel.text = descriptionString
        descriptionUIView.setContentHuggingPriority(UILayoutPriority.init(rawValue: 1), for: .vertical)
    }
    
    private func setupDelete()
    {
        self.addArrangedSubview(deleteUIView)
        deleteWidthConstraint = deleteUIView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.0)
        deleteWidthConstraint.isActive = true
        deleteUIView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0).isActive = true
        deleteUIView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        deleteUIView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        deleteUIView.backgroundColor = .red
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(deleteButtonPressed))
        deleteUIView.addGestureRecognizer(gestureTap)
        
        deleteUIView.addSubview(imageViewDelete)
        deleteImageWidthConstraint = imageViewDelete.widthAnchor.constraint(equalTo: deleteUIView.widthAnchor, multiplier: 0.0)
        deleteImageWidthConstraint.isActive = true
        deleteImageHeightConstraint = imageViewDelete.heightAnchor.constraint(equalTo: deleteUIView.heightAnchor, multiplier: 0.0)
        deleteImageHeightConstraint.isActive = true
        imageViewDelete.centerYAnchor.constraint(equalTo: deleteUIView.centerYAnchor).isActive = true
        imageViewDelete.centerXAnchor.constraint(equalTo: deleteUIView.centerXAnchor).isActive = true
        imageViewDelete.image = UIImage(systemName: "trash")
        imageViewDelete.tintColor = .black
        imageViewDelete.backgroundColor = .red
    }
    
    @objc private func deleteButtonPressed()
    {
        PersistanceService.deleteLocation(pinLocation: (self.pinLocation)!)
        self.parentStackView?.removeArrangedSubview(self)
        self.selfWidthConstraint.isActive = false
        self.selfHeightConstraint.isActive = false
        selfHeightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
        selfWidthConstraint = self.widthAnchor.constraint(equalToConstant: 0)
        selfHeightConstraint.isActive = true
        selfWidthConstraint.isActive = true
    }
    
}
