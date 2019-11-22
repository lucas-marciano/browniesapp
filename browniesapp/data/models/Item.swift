//
//  Item.swift
//  browniesapp
//
//  Created by Lucas de Almeida Marciano on 18/11/19.
//  Copyright © 2019 Inatel. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
     // MARK: - Attributes
    
    var name: String
    var kgcal: Double
    
    // MARK: - Constructor
    
    init(name: String, kgcal: Double){
        self.name = name
        self.kgcal = kgcal
    }
    
    // MARK: - NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(kgcal, forKey: "kgcal")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        kgcal = aDecoder.decodeDouble(forKey: "kgcal")
    }
}
