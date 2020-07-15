//
//  MovieDetailedData.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 15.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import Foundation

extension EndpointCollection {
    
    static func getMovieDetails(for movie: Movie) -> Endpoint {
        return Endpoint(method: .get, pathEnding: "movie/\(movie.id)")
    }
}
