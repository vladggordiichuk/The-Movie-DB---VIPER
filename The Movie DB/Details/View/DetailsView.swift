//
//  DetailsView.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 14.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

final class DetailsView: UIViewController, DetailsViewProtocol {
    
    var presenter: DetailsPresenterProtocol?
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var contentView: UIView = {
        let scrollView = UIView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    private var posterImageView: LoadableImageView = {
        let imageView = LoadableImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func generateStackViewData(title: String, value: String?) -> UIStackView {
        
        let stackView = UIStackView()
        
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.numberOfLines = 0
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(valueLabel)
        
        return stackView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        setUpElements()
    }
    
    private func setUpElements() {
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        scrollView.addSubview(activityView)
        
        activityView.startAnimating()
        
        contentView.addSubview(posterImageView)
        
        contentView.addSubview(detailsStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            activityView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            activityView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 120),
            posterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -120),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5),
            
            detailsStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 50),
            detailsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            detailsStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            detailsStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
        ])
    }
    
    func applyMovieDetails(with movie: Movie) {
        
        activityView.stopAnimating()
        
        posterImageView.setImage(with: movie.poster)
        
        fillDetailsStackView(with: movie)
    }
    
    private func fillDetailsStackView(with movie: Movie) {
        
        detailsStackView.addArrangedSubview(generateStackViewData(title: "Title", value: movie.title))
        
        if let genres = movie.genres?.map({ $0.name }).joined(separator: ", ") {
            detailsStackView.addArrangedSubview(generateStackViewData(title: "Genres", value: genres))
        }
        
        if let releaseDate = movie.releaseDate {
            detailsStackView.addArrangedSubview(generateStackViewData(title: "Release Date", value: releaseDate))
        }
        
        if let revenue = movie.revenue {
            detailsStackView.addArrangedSubview(generateStackViewData(title: "Revenue", value: String(revenue)))
        }
        
        if let duration = movie.duration {
            detailsStackView.addArrangedSubview(generateStackViewData(title: "Duration", value: String(duration)))
        }
        
        if let status = movie.status {
            detailsStackView.addArrangedSubview(generateStackViewData(title: "Status", value: status))
        }
        
        if let voteAverage = movie.voteAverage {
            detailsStackView.addArrangedSubview(generateStackViewData(title: "Vote Average", value: String(voteAverage)))
        }
        
        if let voteCount = movie.voteCount {
            detailsStackView.addArrangedSubview(generateStackViewData(title: "Number Of Votes", value: String(voteCount)))
        }
        
        if let overview = movie.overview {
            detailsStackView.addArrangedSubview(generateStackViewData(title: "Overview", value: overview))
        }
    }
    
    func showErrorAlert(_ reason: String) {
        
        let alert = UIAlertController(title: "Could not load data", message: reason, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Got it", style: .default) { [weak presenter] _ in
            presenter?.cancelDetailsAction()
        }

        alert.addAction(alertAction)

        present(alert, animated: true)
    }
    
    deinit {
        posterImageView.cancelSetImage()
    }
}
