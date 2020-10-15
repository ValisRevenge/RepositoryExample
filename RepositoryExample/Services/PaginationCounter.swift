//
//  PaginationCounter.swift
//  RepositoryExample
//
//  Created by Mishko on 10/15/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation

struct PaginationCounter {
    var itemsPerPage: Int
    var currentPage: Int = 1
    var nextPage: Int = 2
    
    var isLoadingProceed: Bool {
        return nextPage == currentPage
    }
}
