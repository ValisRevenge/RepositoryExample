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
        let request = NSFetchRequest<CatBreed>()
        
        do {
            let breeds = try request.execute()
            completion(breeds)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getAt(startIndex: Int, count: Int, completion: @escaping ([CatBreed]) -> Void) {
        let request = NSFetchRequest<CatBreed>()
        
        if let breeds = try? request.execute(), breeds.count > startIndex + count  {
            
            let breedsSlice = breeds[startIndex...startIndex+count]
            completion(Array(breedsSlice))
            DBManager.shared.saveDefault()
        }
    }
    
    func removeAll() {
        DBManager.shared.removeAllEntitiesWithName("CatBreed")
    }
}
