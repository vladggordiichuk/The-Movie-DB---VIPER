//
//  Movie.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 14.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import Foundation

struct Movie {
    
    let id: Int
    let title: String
    let popularity: Float
    let poster: URL?
    
    // Additional Info
    
    var genres: [Genre]?
    var releaseDate: String?
    var revenue: Int?
    var duration: Int?
    var status: String?
    var voteAverage: Float?
    var voteCount: Int?
    var overview: String?
    
    struct Genre: Decodable {
        let id: Int
        let name: String
    }
}

extension Movie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id, title, popularity
        case poster = "poster_path"
        case genres
        case releaseDate = "release_date"
        case revenue
        case duration = "runtime"
        case status
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case overview
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        popularity = try container.decode(Float.self, forKey: .popularity)
        
        if
            let posterString = try? container.decode(String.self, forKey: .poster),
            let posterUrl = URL(string: "https://image.tmdb.org/t/p/w1280" + posterString) {
            
            poster = posterUrl
        } else { poster = nil }
        
        do {
            genres = try container.decode([Genre].self, forKey: .genres)
            releaseDate = try container.decode(String.self, forKey: .releaseDate)
            revenue = try container.decode(Int.self, forKey: .revenue)
            duration = try container.decode(Int.self, forKey: .duration)
            status = try container.decode(String.self, forKey: .status)
            voteAverage = try container.decode(Float.self, forKey: .voteAverage)
            voteCount = try container.decode(Int.self, forKey: .voteCount)
            overview = try container.decode(String.self, forKey: .overview)
        } catch {
            genres = nil
            releaseDate = nil
            revenue = nil
            duration = nil
            status = nil
            voteAverage = nil
            voteCount = nil
            overview = nil
        }
    }
}
