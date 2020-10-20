//
//  CatBreed+CoreDataProperties.swift
//  RepositoryExample
//
//  Created by Aleksey on 10/19/20.
//  Copyright © 2020 byMishko. All rights reserved.
//
//

import Foundation
import CoreData


extension CatBreed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatBreed> {
        return NSFetchRequest<CatBreed>(entityName: "CatBreed")
    }

    @NSManaged public var breedId: String?
    @NSManaged public var name: String?
    @NSManaged public var otherNames: String?
    @NSManaged public var lifeSpan: String?
    @NSManaged public var hairless: Bool
    @NSManaged public var rare: Bool
    @NSManaged public var origin: String?
    @NSManaged public var temperament: String?
    @NSManaged public var intelligence: NSNumber?

}
