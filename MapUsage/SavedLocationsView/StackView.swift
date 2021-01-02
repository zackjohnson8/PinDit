//
//  StackView.swift
//  MapUsage
//
//  Created by Zachary Johnson on 1/1/21.
//  Copyright © 2021 Zachary Johnson. All rights reserved.
//

import Foundation
import UIKit

class StackView:UIStackView
{
    @IBOutlet weak var noContentLabel:UILabel?
    
    override func didMoveToSuperview()
    {
        super.didMoveToSuperview()
    }
    
    override func removeArrangedSubview(_ view: UIView) {
        super.removeArrangedSubview(view)
        let subviews = self.arrangedSubviews
        if subviews.count == 1
        {
            noContentLabel?.isHidden = false
        }
    }
    
    override func addArrangedSubview(_ view: UIView) {
        super.addArrangedSubview(view)
        noContentLabel?.isHidden = true
    }



}
