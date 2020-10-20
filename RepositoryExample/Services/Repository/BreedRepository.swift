//
//  BreedRepository.swift
//  RepositoryExample
//
//  Created by Mishko on 10/19/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation

protocol BreedRepository {
    func getAll(completion: @escaping (_: [CatBreed]) -> Void)
    func getAt(startIndex: Int, count: Int, completion: @escaping (_: [CatBreed]) -> Void)
    func loadBreedImages(breedId: String,
                         page: Int,
                         itemsPerPage: Int,
                         completion: @escaping (_: [Photo]) -> Void)
    func removeAll()
}
