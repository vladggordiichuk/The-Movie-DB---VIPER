//
//  ListTableCell.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 14.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

final class ListTableCell: UITableViewCell {
    
    static let reuseIdentifier = "ListTableCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setUpElements(_ movie: Movie) {
        
        textLabel?.text = movie.title
        detailTextLabel?.text = String(format: "Popularity of this movie is %.2f", movie.popularity)
        imageView?.contentMode = .scaleAspectFit
        imageView?.setImage(with: movie.poster)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView?.cancelSetImage()
    }
}
