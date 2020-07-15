//
//  ListView.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 14.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

final class ListView: UITableViewController {
    
    var presenter: ListPresenterProtocol?
    
    private var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        title = "The Movie DB"
        
        tableView.register(ListTableCell.self, forCellReuseIdentifier: ListTableCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
}

extension ListView: ListViewProtocol {
    
    func reloadInterface(with movies: [Movie]) {
        
        movieList += movies
        
        tableView.beginUpdates()
        tableView.insertRows(at: ((movieList.count - movies.count) ..< movieList.count).map({ IndexPath(row: $0, section: 0) }), with: .automatic)
        tableView.endUpdates()
    }
}

extension ListView {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableCell.reuseIdentifier) as? ListTableCell else { return UITableViewCell() }
        cell.setUpElements(movieList[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        presenter?.showMovieDetails(from: self, with: movieList[indexPath.row])
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let currentMaxRow = tableView.indexPathsForVisibleRows?.max(by: { $0.row < $1.row })?.row else { return }
        
        if currentMaxRow > movieList.count - 4 {
            presenter?.fetchMovieList()
        }
    }
}
