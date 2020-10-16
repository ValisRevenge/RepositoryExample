//
//  CatBreed.swift
//  RepositoryExample
//
//  Created by Mishko on 10/12/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation

struct CatBreed: Codable {
    
    let id: String
    let name: String
    let otherNames: String?
    let lifeSpan: String
    let hairless: Bool
    let rare: Bool
    let origin: String
    let temperament: String
    let weightImperial: String?
    
    enum Keys: String, CodingKey {
        case id
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
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        otherNames = nil
        lifeSpan = try container.decode(String.self, forKey: .life_span)
        
        let hairLevel: Int = try container.decode(Int.self, forKey: .hairless)
        hairless = hairLevel == 1
        
        let rareLevel = try container.decode(Int.self, forKey: .rare)
        rare = rareLevel == 1
        origin = try container.decode(String.self, forKey: .origin)
        temperament = try container.decode(String.self, forKey: .temperament)
        weightImperial = try? container.decode(String.self, forKey: .weight_imperial)
    }
}
