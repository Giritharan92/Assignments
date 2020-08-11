//
//  APIService.swift
//  Assignment
//
//  Copyright © 2020 Giri. All rights reserved.
//

import UIKit


class CountryTableModel: NSObject {

    //MARK: Properties
    var title: String
    var rows: Array<CountryModel>

    //MARK: Init
    init(text: String) {
        title = text
        rows = []
    }
    
    convenience init(object: Dictionary<String, AnyObject>) {
        self.init(text: object.stringForKey("title"))

        if let rows = object["rows"] as? Array<Dictionary<String, AnyObject>> {
            self.rows = CountryModel.countryDataList(rows)
        }
     }
}

