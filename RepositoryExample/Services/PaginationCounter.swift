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
    var currentPage: Int = 0
    var isLoadingProceed: Bool = false
    var isLimitReached: Bool = false
    
    init(itemsPerPage: Int) {
        self.itemsPerPage = itemsPerPage
    }
}
