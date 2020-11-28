//
//  CreateUIButton.swift
//  MapUsage
//
//  Created by Zachary Johnson on 11/27/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation
import UIKit

class CreateUIButton: UIButton
{
    override func didMoveToWindow()
    {
        translatesAutoresizingMaskIntoConstraints = false
        
        self.widthAnchor.constraint(equalToConstant: 0).isActive = true
        self.heightAnchor.constraint(equalToConstant: 0).isActive = true
    }
}
