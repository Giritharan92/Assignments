//
//  Country.swift
//  Assignment
//
//  Copyright © 2020 Giri. All rights reserved.
//

import Foundation

class CountryDTO {
    var countryTitle: String?
    var countryRows : [CountryRowsDTO] =  [CountryRowsDTO]()
}

class CountryRowsDTO {
    var title : String?
    var description: String?
    var image: String?
}
