//
//  DetailsWireFrame.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 14.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

final class DetailsWireFrame: DetailsWireFrameProtocol {
    
    static func createDetailsModule(with movie: Movie) -> UIViewController {
        
        let view = DetailsView()
        
        let presenter: DetailsPresenterProtocol & DetailsInteractorOutputProtocol = DetailsPresenter()
        let interactor: DetailsInteractorInputProtocol = DetailsInteractor()
        let wireFrame: DetailsWireFrameProtocol = DetailsWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.movie = movie
        
        return UINavigationController(rootViewController: view)
    }
    
    func dismissDetailsInterface(from view: DetailsViewProtocol) {
        
        if let view = view as? UIViewController {
            view.dismiss(animated: true, completion: nil)
        }
    }
}

