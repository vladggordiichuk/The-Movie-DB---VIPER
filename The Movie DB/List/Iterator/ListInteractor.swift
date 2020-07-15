//
//  ListInteractor.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 14.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import Foundation

final class ListInteractor: ListInteractorInputProtocol {
    
    weak var presenter: ListInteractorOutputProtocol?
    
    var pagination = PaginationRequest()
    
    var isPerformingRequest: Bool = false
    
    func retrieveMovies(_ isForceRequest: Bool = false) {
        
        guard pagination.isRequestAllowed, (!isPerformingRequest || isForceRequest) else { return }
        
        isPerformingRequest = true
        
        NetworkManager.shared.performRequest(to: EndpointCollection.getMovieList(), with: pagination) { [weak self, weak presenter, weak pagination] (result: Result<MovieListEndpoint>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    pagination?.increasePage()
                    presenter?.didRetrieveMovies(response.results)
                    self?.isPerformingRequest = false
                case .failure(_):
                    self?.retrieveMovies(true)
                }
            }
        }
    }
}
