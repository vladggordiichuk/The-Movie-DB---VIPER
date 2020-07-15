//
//  ListPresenter.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 14.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import Foundation

final class ListPresenter: ListPresenterProtocol {
    
    weak var view: ListViewProtocol?
    var interactor: ListInteractorInputProtocol?
    var wireFrame: ListWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.retrieveMovies(false)
    }
    
    func showMovieDetails(from view: ListViewProtocol, with movie: Movie) {
        wireFrame?.presentMovieDetailScreen(from: view, with: movie)
    }
}

extension ListPresenter: ListInteractorOutputProtocol {
    
    func didRetrieveMovies(_ movies: [Movie]) {
        view?.reloadInterface(with: movies)
    }
}
