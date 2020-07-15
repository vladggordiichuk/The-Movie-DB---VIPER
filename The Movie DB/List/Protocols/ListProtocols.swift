//
//  ListProtocols.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 14.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

protocol ListViewProtocol: class {
    
    var presenter: ListPresenterProtocol? { get set }
    
    func reloadInterface(with movies: [Movie])
}

protocol ListWireFrameProtocol: class {
    
    static func createListModule() -> UIViewController
    
    func presentMovieDetailScreen(from view: ListViewProtocol, with movie: Movie)
}

protocol ListPresenterProtocol: class {
    
    var view: ListViewProtocol? { get set }
    var interactor: ListInteractorInputProtocol? { get set }
    var wireFrame: ListWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func showMovieDetails(from view: ListViewProtocol, with movie: Movie)
}

protocol ListInteractorOutputProtocol: class {
    
    func didRetrieveMovies(_ movies: [Movie])
}

protocol ListInteractorInputProtocol: class {
    
    var presenter: ListInteractorOutputProtocol? { get set }
    
    func retrieveMovies(_ isForceRequest: Bool)
}
