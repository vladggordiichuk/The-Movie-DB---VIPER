//
//  DetailsProtocols.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 14.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

protocol DetailsViewProtocol: class {
    
    var presenter: DetailsPresenterProtocol? { get set }
    
    func applyMovieDetails(with movie: Movie)
    func showErrorAlert(_ reason: String)
}

protocol DetailsWireFrameProtocol: class {
    
    static func createDetailsModule(with movie: Movie) -> UIViewController
    
    func dismissDetailsInterface(from view: DetailsViewProtocol)
}

protocol DetailsPresenterProtocol: class {
    
    var view: DetailsViewProtocol? { get set }
    var interactor: DetailsInteractorInputProtocol? { get set }
    var wireFrame: DetailsWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func cancelDetailsAction()
}

protocol DetailsInteractorOutputProtocol: class {
    
    func didRetrieveMovie(_ movie: Movie)
    func didFailRequest(_ reason: String)
}

protocol DetailsInteractorInputProtocol: class {
    
    var presenter: DetailsInteractorOutputProtocol? { get set }
    
    var movie: Movie? { get set }

    func retrieveMovie()
}
