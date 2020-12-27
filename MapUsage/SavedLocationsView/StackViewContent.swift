//
//  StackViewContent.swift
//  MapUsage
//
//  Created by Zachary Johnson on 10/12/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation
import UIKit

class StackViewContent: UIStackView
{
    private lazy var titleString:String? = nil
    private lazy var descriptionString:String? = nil
    private lazy var imageString:String? = nil
    private lazy var parentStackView:UIStackView? = nil
    
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
    
    public func initialize(parent: UIStackView, title: String, description: String, image: String)
    {
        parentStackView = parent
        titleString = title
        descriptionString = description
        imageString = image
        
        setConstraints()
        setupImage()
        setupVerticalStack()
        setupTitle()
        setupDescription()
        
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
    
    private func setConstraints()
    {
        self.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        self.widthAnchor.constraint(equalTo: parentStackView!.widthAnchor, multiplier: 0.97).isActive = true
    }
    
    private func setupImage()
    {
        // Add image to left side of view
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
    
}
