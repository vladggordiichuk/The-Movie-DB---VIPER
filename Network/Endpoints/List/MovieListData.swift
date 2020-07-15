//
//  MovieListData.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 15.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import Foundation

struct MovieListEndpoint: Decodable {
    
    let page: Int
    let pageCount: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case pageCount = "total_pages"
        case results
    }
}

extension EndpointCollection {
    
    static func getMovieList() -> Endpoint {
        return Endpoint(method: .get, pathEnding: "movie/popular")
    }
}
