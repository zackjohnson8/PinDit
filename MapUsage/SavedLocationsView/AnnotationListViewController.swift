//
//  AnnotationListViewController.swift
//  MapUsage
//
//  Created by Zachary Johnson on 6/8/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import UIKit
import TinyConstraints
import CoreData

class AnnotationListViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: StackView!
    @IBOutlet weak var noContentLabel: UILabel!
    private lazy var scrollViewSize = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let pinData = Database.GetPinData()
        
        // Handles any new pins that are added while the app is running.
        if pinData.count > scrollViewSize && scrollView != nil
        {
            for n in scrollViewSize+1...pinData.count
            {
                scrollViewSize += 1
                let newUIView: StackViewContent = StackViewContent()
                stackView.addArrangedSubview(newUIView)
                newUIView.initialize(parent: stackView, pinLocation: pinData[n - 1], image: "pindrop")
                
                // Add swipe gesture
                let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
                leftSwipeGesture.direction = [.left]
                let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe)) // default right direction
                newUIView.addGestureRecognizer(leftSwipeGesture)
                newUIView.addGestureRecognizer(rightSwipeGesture)
            }
            self.view.layoutIfNeeded()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.cornerRadius = 10.0
        SetupStackView()
        SetupScrollViewConstraints()
        SetupScrollView()
                
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor, UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.layer.frame
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    fileprivate func SetupStackView()
    {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10.0
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    fileprivate func SetupScrollViewConstraints()
    {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // scrollView contraints (parent this) requires atleast iOS 11
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        // stackView constraints (parent scrollView)
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        scrollView.addSubview(noContentLabel)
        NSLayoutConstraint.activate([
            noContentLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
            noContentLabel.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.4),
            noContentLabel.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            noContentLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    fileprivate func SetupScrollView()
    {
        let pinData = Database.GetPinData()
        for pin in pinData
        {
            scrollViewSize += 1
            let newUIView: StackViewContent = StackViewContent()
            stackView.addArrangedSubview(newUIView)
            newUIView.initialize(parent: stackView, pinLocation: pin, image: "pindrop")
            
            // Add swipe gesture
            let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            leftSwipeGesture.direction = [.left]
            let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe)) // default right direction
            newUIView.addGestureRecognizer(leftSwipeGesture)
            newUIView.addGestureRecognizer(rightSwipeGesture)
        }
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer)
    {
        let sender_m = sender.view as! StackViewContent
        sender_m.handleSwipe(sender)
        
        UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            self.view.layoutIfNeeded()
        }.startAnimation()
    }
}

