//
//  CountryDataBase+CoreDataProperties.swift
//  Assignment
//
//  Copyright © 2020 Giri. All rights reserved.
//
//

import Foundation
import CoreData


extension CountryDataBase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryDataBase> {
        return NSFetchRequest<CountryDataBase>(entityName: "CountryDataBase")
    }

    @NSManaged public var countryTitle: String?
    @NSManaged public var countryDescription: String?
    @NSManaged public var countryImage: String?
    @NSManaged public var navigationTitle: String?

}
