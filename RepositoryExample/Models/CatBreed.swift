//
//  CatBreed.swift
//  RepositoryExample
//
//  Created by Aleksey on 10/12/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation

struct CatBreed: Codable {
    
    let name: String
    let otherNames: String?
    let lifeSpan: String
    let hairless: Bool
    let rare: Int
    let origin: String
    let temperament: String
    let weightImperial: String
    
    enum Keys: String, CodingKey {
        case name
        case origin
        case rare
        case hairless
        case alt_names
        case temperament
        case weight_imperial
        case life_span
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        name = try container.decode(String.self, forKey: .name)
        otherNames = nil
        lifeSpan = try container.decode(String.self, forKey: .life_span)
        hairless = try container.decode(Bool.self, forKey: .hairless)
        rare = try container.decode(Int.self, forKey: .rare)
        origin = try container.decode(String.self, forKey: .origin)
        temperament = try container.decode(String.self, forKey: .temperament)
        weightImperial = try container.decode(String.self, forKey: .weight_imperial)
    }
}
