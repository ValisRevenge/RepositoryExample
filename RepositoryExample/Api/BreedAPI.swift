//
//  BreedAPI.swift
//  RepositoryExample
//
//  Created by Mishko on 10/12/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation
import Alamofire

protocol API {
    var path: String { get }
    var headers: [String:String] { get }
    var params: [String: Any] { get }
    var encoding: ParameterEncoding { get }
    var url: URL { get }
}

enum BreedAPI: API {
    
    case allBreeds(page: Int, limit: Int)
    case imagesBy(breedId: String, page: Int, limit: Int)
    
    var path: String {
        switch self {
        case .allBreeds:
            return "/breeds"
        case .imagesBy:
            return "/images/search"
        }
    }
    
    var url: URL {
        let baseUrl: String = "https://api.thecatapi.com/v1"
        return URL(string: baseUrl + path)!
    }
    
    var headers: [String : String] {
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary,
            let key = infoDictionary["api_key"] as? String else {
                return [:]
        }
        return ["x-api-key": key]
    }
    
    var params: [String : Any] {
        switch self {
        case .allBreeds(page: let currentPage, limit: let breedsPerPage):
            return ["page": currentPage, "limit": breedsPerPage]
        case .imagesBy(breedId: let id, page: let currentPage, limit: let breedsPerPage):
            return ["page": currentPage, "limit": breedsPerPage, "breed_id": id, "size": 300]
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}
