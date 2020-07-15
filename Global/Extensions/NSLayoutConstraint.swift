//
//  NSLayoutConstraint.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 15.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        
        let constraint = self
        constraint.priority = priority
        return constraint
    }
}
