//
//  BreedService.swift
//  RepositoryExample
//
//  Created by Mishko on 10/25/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation

protocol BreedService {
    
    func getAll(completion: @escaping (_: [CatBreed]) -> Void)
    func getAt(startPage: Int, count: Int, completion: @escaping (_: [CatBreed]) -> Void)
    func loadBreedImages(breedId: String,
                         page: Int,
                         itemsPerPage: Int,
                         completion: @escaping (_: [Photo]) -> Void)
    func removeAll()
}
