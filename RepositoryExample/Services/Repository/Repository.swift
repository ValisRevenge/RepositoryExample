//
//  Repository.swift
//  RepositoryExample
//
//  Created by Mishko on 10/21/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

final class Repository {
    
    private var service: BreedRepository = BreedLocalService()
}

extension Repository: BreedRepository {
    
    func loadBreedImages(breedId: String,
                         page: Int,
                         itemsPerPage: Int,
                         completion: @escaping ([Photo]) -> Void) {
        
        service.loadBreedImages(breedId: breedId,
                                page: page,
                                itemsPerPage: itemsPerPage,
                                completion: completion)
    }
    
    func getAll(completion: @escaping ([CatBreed]) -> Void) {
        
        service.getAll { [weak self] breeds in
            
            guard let `self` = self else { return }
            
            if breeds.count == 0, self.service is BreedLocalService {
                self.service = BreedWebService()
                self.getAll(completion: completion)
                return
            } else if self.service is BreedWebService {
                DBManager.shared.saveDefault()
            }
            completion(breeds)
        }
    }
    
    func getAt(startPage: Int,
               count: Int,
               completion: @escaping ([CatBreed]) -> Void) {
        
            service.getAt(startPage: startPage, count: count) { [weak self] breeds in
                
                guard let `self` = self else { return }
                
                if breeds.count == 0, self.service is BreedLocalService {
                    self.service = BreedWebService()
                    self.service.getAt(startPage: startPage, count: count, completion: completion)
                    return
                } else if self.service is BreedWebService {
                    DBManager.shared.saveDefault()
                }
                completion(breeds)
            }
    }
    
    func removeAll() {
        service.removeAll()
    }
}
