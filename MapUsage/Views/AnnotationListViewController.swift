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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10.0
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.backgroundColor = .gray
        SetupScrollViewConstraints()
        SetupScrollView()
        
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
        
        // frameLayoutGuide constraints (parent scrollView)
//        let frameGuide = scrollView.frameLayoutGuide
//        NSLayoutConstraint.activate([
//            frameGuide.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            frameGuide.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            frameGuide.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            frameGuide.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
//        ])
//
//        // contentLayoutGuide constraints (parent scrollView)
//        let contentGuide = scrollView.contentLayoutGuide
//        NSLayoutConstraint.activate([
//            contentGuide.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentGuide.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentGuide.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentGuide.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
//        ])
        
        // stackView constraints (parent scrollView)
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    fileprivate func SetupScrollView()
    {
        let fetchRequest: NSFetchRequest<PinLocation> = PinLocation.fetchRequest()
        
        do {
            let pinLocation = try PersistanceService.context.fetch(fetchRequest)
            for pin in pinLocation
            {
                let newUIView: UIView = {
                    let newUIView = UIView()
                    newUIView.translatesAutoresizingMaskIntoConstraints = false
                    newUIView.backgroundColor = .red
    
                    return newUIView
                }()

                if scrollView.subviews.count == 3 // This means there is only the first added UIView
                {
                    // Place the constraint to the top of superview
                    stackView.addArrangedSubview(newUIView)
                    newUIView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
                    
                    
                }else
                {
                    // Place the constraint to previously placed newUIView
                    //var previousAddedSubView = scrollView.subviews.last
                    //print(scrollView.subviews.count)
                    stackView.addArrangedSubview(newUIView)
                    newUIView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
                    
                    //newUIView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true

                }
            }
        }catch
        {
            print("Failed to load pin data")
        }

    }
    
}

