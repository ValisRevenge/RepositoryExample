//
//  BreedAPI.swift
//  RepositoryExample
//
//  Created by Aleksey on 10/12/20.
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
    case imagesBy(breedId: Int)
    
    var path: String {
        switch self {
        case .allBreeds:
            return "/breeds"
        case .imagesBy:
            return ""
        }
    }
    
    var url: URL {
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary,
            let baseUrl = infoDictionary["api_key"] as? String else {
                return URL(string: "")!
        }
        return URL(string: baseUrl + path)!
    }
    
    var headers: [String : String] {
        return ["Name": "api_key", "Location": ""]
    }
    
    var params: [String : Any] {
        switch self {
        case .allBreeds(page: let currentPage, limit: let breedsPerPage):
            return ["page": currentPage, "limit": breedsPerPage]
        case .imagesBy(breedId: let id):
            return [:]
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}
