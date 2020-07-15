//
//  DetailsInteractor.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 14.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import Foundation

final class DetailsInteractor: DetailsInteractorInputProtocol {
    
    weak var presenter: DetailsInteractorOutputProtocol?
    
    var movie: Movie?
    var urlTask: URLSessionTask?
    
    func retrieveMovie() {
        
        guard let movie = movie else { return }
        
        urlTask = NetworkManager.shared.performRequest(to: EndpointCollection.getMovieDetails(for: movie), with: EmptyRequest()) { [weak presenter] (result: Result<Movie>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let movie): presenter?.didRetrieveMovie(movie)
                case .failure(let error): presenter?.didFailRequest(error.localizedDescription)
                }
            }
        }
    }
    
    deinit {
        
        guard let urlTask = urlTask else { return }
        
        urlTask.suspend()
        urlTask.cancel()
    }
}
