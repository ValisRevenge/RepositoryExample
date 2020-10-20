//
//  LocalRepository.swift
//  RepositoryExample
//
//  Created by Mishko on 10/19/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation
import CoreData

class LocalRepository: BreedRepository {
    
    func loadBreedImages(breedId: String, page: Int, itemsPerPage: Int, completion: @escaping ([Photo]) -> Void) {
        //
    }
    
    func getAll(completion: @escaping ([CatBreed]) -> Void) {
        let request = NSFetchRequest<CatBreed>(entityName: "CatBreed")
        
        do {
            let breeds = try DBManager.shared.defaultContext.fetch(request)
            
            completion(breeds)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getAt(startPage: Int, count: Int, completion: @escaping ([CatBreed]) -> Void) {
        let request = NSFetchRequest<CatBreed>(entityName: "CatBreed")

        let startIndex = startPage * count
        
        if var breeds = try? DBManager.shared.defaultContext.fetch(request), breeds.count > startIndex {
            breeds.sort(by: { b1, b2 in
                if let name1 = b1.name, let name2 = b2.name {
                    return name1 < name2
                }
                return true
            })
            
            let endIndex = breeds.count > (startIndex + count - 1) ?
                (startIndex + count - 1) : breeds.count - 1
            
            let breedsSlice = breeds[startIndex...endIndex]
            
            completion(Array(breedsSlice))
        } else {
            completion([])
        }
    }
    
    func removeAll() {
        DBManager.shared.removeAllEntitiesWithName("CatBreed")
    }
}
