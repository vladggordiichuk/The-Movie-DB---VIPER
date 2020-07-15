//
//  ListWireFrame.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 14.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

final class ListWireFrame: ListWireFrameProtocol {
    
    static func createListModule() -> UIViewController {
        
        let view = ListView()
        
        let presenter: ListPresenterProtocol & ListInteractorOutputProtocol = ListPresenter()
        let interactor: ListInteractorInputProtocol = ListInteractor()
        let wireFrame: ListWireFrameProtocol = ListWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
    
    func presentMovieDetailScreen(from view: ListViewProtocol, with movie: Movie) {
        
        guard let sourceView = view as? UIViewController else { return }
        
        let addContactsView = DetailsWireFrame.createDetailsModule(with: movie)
        sourceView.present(addContactsView, animated: true, completion: nil)
    }
}
