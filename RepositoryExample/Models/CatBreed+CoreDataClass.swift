//
//  CatBreed+CoreDataClass.swift
//  RepositoryExample
//
//  Created by Mishko on 10/19/20.
//  Copyright © 2020 byMishko. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CatBreed)
public class CatBreed: NSManagedObject, Decodable {
    
    var intelligenceScore: Intelligence {
        if let value = intelligence?.int8Value {
            return Intelligence(rawValue: value) ?? .unknown
        }
        return .unknown
    }

    enum Keys: String, CodingKey {
        case id
        case name
        case origin
        case rare
        case hairless
        case alt_names
        case temperament
        case intelligence
        case life_span
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        let context = DBManager.shared.defaultContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: CatBreed.description(), in: context) else {
            fatalError("Failed to create entity description")
        }
        
        self.init(entity: entityDescription, insertInto: context)
        
        let container = try decoder.container(keyedBy: Keys.self)
        
        breedId = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        otherNames = nil
        lifeSpan = try container.decode(String.self, forKey: .life_span)
        
        let hairLevel: Int = try container.decode(Int.self, forKey: .hairless)
        hairless = hairLevel == 1
        
        let rareLevel = try container.decode(Int.self, forKey: .rare)
        rare = rareLevel == 1
        origin = try container.decode(String.self, forKey: .origin)
        temperament = try container.decode(String.self, forKey: .temperament)
        
        if let intellectScore = try? container.decode(Int.self, forKey: .intelligence) {
            intelligence = NSNumber(integerLiteral: intellectScore)
        }
    }
}
