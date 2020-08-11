//
//  CountryDataBase+CoreDataClass.swift
//  Assignment
//
//  Copyright © 2020 Giri. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CountryDataBase)
public class CountryDataBase: NSManagedObject {

    class func saveCountryDetails(countryInfo:CountryRowsDTO, title: String)
    {
        let countryDetails = HCoreDataHandler().getEntity(entityName: "CountryDataBase") as! CountryDataBase
        countryDetails.countryTitle = countryInfo.title
        countryDetails.countryImage = countryInfo.image
        countryDetails.countryDescription = countryInfo.description
        countryDetails.navigationTitle = title
        HCoreDataHandler().saveEntity(entity: countryDetails)
    }

}
