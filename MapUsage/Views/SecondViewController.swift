//
//  SecondViewController.swift
//  MapUsage
//
//  Created by Zachary Johnson on 6/8/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import UIKit
import TinyConstraints

class SecondViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetupScrollView()
        SetupContainingViews()
    }
    
    fileprivate func SetupScrollView()
    {
        scrollView.edgesToSuperview(excluding: .none, insets: .zero, relation: .equal, priority: .defaultHigh, isActive: true, usingSafeArea: true)
        scrollView.backgroundColor = .white
    }
    
    fileprivate func SetupContainingViews()
    {
    
        
    }
}

