//
//  DetailsPresenter.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 14.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

final class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewProtocol?
    var interactor: DetailsInteractorInputProtocol?
    var wireFrame: DetailsWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.retrieveMovie()
    }
    
    func cancelDetailsAction() {
        
        guard let view = view else { return }
        wireFrame?.dismissDetailsInterface(from: view)
    }
}

extension DetailsPresenter: DetailsInteractorOutputProtocol {
    
    func didRetrieveMovie(_ movie: Movie) {
        
        guard let view = view else { return }
        view.applyMovieDetails(with: movie)
    }
    
    func didFailRequest(_ reason: String) {
        
        guard let view = view else { return }
        view.showErrorAlert(reason)
    }
}
