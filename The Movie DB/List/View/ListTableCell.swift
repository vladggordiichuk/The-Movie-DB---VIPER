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
    
    private var posterImageView: LoadableImageView = {
        let imageView = LoadableImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var popularityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setUpElements()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setUpElements() {
        
        contentView.addSubview(posterImageView)
        
        contentView.addSubview(textStackView)
        
        textStackView.addArrangedSubview(titleLabel)
        
        textStackView.addArrangedSubview(popularityLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),
            posterImageView.widthAnchor.constraint(equalToConstant: 90),
            
            
            textStackView.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            textStackView.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 25),
            textStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30)
        ])
    }
    
    func setUpElements(_ movie: Movie) {
        
        posterImageView.setImage(with: movie.poster)
        titleLabel.text = movie.title
        popularityLabel.text = String(format: "Popularity of this movie is %.2f", movie.popularity)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.cancelSetImage()
    }
}
