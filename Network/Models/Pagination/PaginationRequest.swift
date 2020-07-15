//
//  PaginationRequest.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 15.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import Foundation

final class PaginationRequest: Encodable {
    
    private var page: Int = 1
    
    func increasePage() {
        page += 1
    }
    
    var isRequestAllowed: Bool { page <= 5 }
}
