//
//  BreedRepository.swift
//  RepositoryExample
//
//  Created by Mishko on 10/19/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation

protocol BreedRepository {
    
    associatedtype T
    
    func getAll(completion: @escaping (_: [T]) -> Void)
    func getAt(startPage: Int, count: Int, completion: @escaping (_: [T]) -> Void)
    func loadImages(breedId: String,
                         page: Int,
                         itemsPerPage: Int,
                         completion: @escaping (_: [Photo]) -> Void)
    func removeAll()
}
