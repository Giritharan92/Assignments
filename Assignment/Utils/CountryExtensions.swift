//
//  CountryExtensions.swift
//  Assignment
//
//  Copyright © 2020 Giri. All rights reserved.
//

import Foundation
import SDWebImage

extension Dictionary {
    
    func stringForKey(_ key: Key) -> String {
        if let string = self[key] as? String {
            return string
        }
        return ""
    }
    
    func toData() -> Data {
        return try! JSONSerialization.data(withJSONObject: self, options: [])
    }
    
    func toJsonString() -> String {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        return jsonString
    }
}

extension String {
    var length: Int {
        return self.count
    }
}

extension UIImageView {
    
    func normalLoad(_ string: String) {
        if let url = URL(string: string) {
            self.sd_setImage(with: url, placeholderImage: UIImage(named: "SampleImage")!)
        } else {
            self.image = UIImage(named: "SampleImage")
        }
    }
}
