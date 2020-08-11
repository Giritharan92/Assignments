//
//  CountryDataModel.swift
//  Assignment
//
//  Copyright © 2020 Giri. All rights reserved.
//


import UIKit

class CountryModel: NSObject {
    
    //MARK: Properties
    var title = ""
    var imageDescription = ""
    var imageName = ""
    var image: UIImage?

    //MARK: Class functions

    class func countryRow(_ object: Dictionary<String, AnyObject>) -> CountryModel {
        
        let modal = CountryModel()
        modal.title = object.stringForKey("title")
        modal.imageDescription = object.stringForKey("description")
        modal.imageName = object.stringForKey("imageHref")

        return modal
    }
    
    class func countryDataList(_ array: Array<Dictionary<String, AnyObject>>) -> Array<CountryModel> {
        
        var list = [CountryModel]()
        for object in array {
            
            let modal = CountryModel.countryRow(object)
            if modal.title.length == 0 && modal.imageName.length == 0 {
                continue
            }
            list.append(modal)
        }
        
        return list
    }
}
