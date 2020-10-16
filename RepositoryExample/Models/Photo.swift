//
//  Photo.swift
//  RepositoryExample
//
//  Created by Mishko on 10/16/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let id: String
    let url: URL?
    
    enum Keys: String, CodingKey {
        case id
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let text: String = try container.decode(String.self, forKey: .url)
        url = URL(string: text)
    }
}
