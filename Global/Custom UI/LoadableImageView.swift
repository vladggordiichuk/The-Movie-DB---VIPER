//
//  LoadableImageView.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 15.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

class LoadableImageView: UIImageView {
    
    private var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setUpElements()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setUpElements() {
        
        addSubview(activityView)
        
        NSLayoutConstraint.activate([
            activityView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func showActivityIndicator() {
        activityView.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityView.stopAnimating()
    }
}
