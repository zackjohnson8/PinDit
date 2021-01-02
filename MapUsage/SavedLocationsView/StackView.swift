//
//  StackView.swift
//  MapUsage
//
//  Created by Zachary Johnson on 1/1/21.
//  Copyright © 2021 Zachary Johnson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StackView:UIStackView
{
    @IBOutlet weak var noContentLabel:UILabel?
    
    override func didMoveToSuperview()
    {
        super.didMoveToSuperview()
    }
    
    override func removeArrangedSubview(_ view: UIView) {
        super.removeArrangedSubview(view)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PinLocation")
        do{
            let fetchedItems = try PersistanceService.context.fetch(fetchRequest)
            if fetchedItems.isEmpty
            {
                noContentLabel?.isHidden = false
            }
        }catch
        {
            print("Error fetching data for Pin Locations")
        }
    }
    
    override func addArrangedSubview(_ view: UIView) {
        super.addArrangedSubview(view)
        noContentLabel?.isHidden = true
    }



}
