//
//  AnnotationListViewController.swift
//  MapUsage
//
//  Created by Zachary Johnson on 6/8/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import UIKit
import TinyConstraints

class AnnotationListViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupScrollView()
        SetupContainingViews()
    }
    
    fileprivate func SetupScrollView()
    {
        scrollView.edgesToSuperview(excluding: .none, insets: .zero, relation: .equal, priority: .defaultHigh, isActive: true, usingSafeArea: true)
        scrollView.backgroundColor = .gray
        scrollView.showsVerticalScrollIndicator = true
        scrollView.bounces = true
        scrollView.
        
        // Populate the scrollView with all saved pins
        //for pin in Database.GetPinData()
        //{
        for n in 1...10
        {
            let newUIView: UIView = {
                let newUIView = UIView.init()
                
                if( n % 2 == 0)
                {
                    newUIView.backgroundColor = .blue
                }else
                {
                    newUIView.backgroundColor = .red
                }
                
            
                return newUIView
            }()
        
            scrollView.addSubview(newUIView)
            
            newUIView.widthToSuperview(scrollView.widthAnchor, multiplier: 1, offset: 0, relation: .equal, priority: .defaultHigh, isActive: true, usingSafeArea: true)
            newUIView.heightToSuperview(scrollView.heightAnchor, multiplier: 0.20, offset: 0, relation: .equal, priority: .defaultHigh, isActive: true, usingSafeArea: true)
        }
            
        
        
        //}
    }
    
    fileprivate func SetupContainingViews()
    {
    
        
    }
}

