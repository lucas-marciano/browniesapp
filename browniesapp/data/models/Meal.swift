//
//  Meal.swift
//  browniesapp
//
//  Created by Lucas de Almeida Marciano on 18/11/19.
//  Copyright © 2019 Inatel. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    
    // MARK: - Attributes
    
    var name: String
    var note: Int
    var itens: [Item]
    
    // MARK: - Constructor
    
    init(name: String, note: Int, itens: [Item] = []){
        self.name = name
        self.note = note
        self.itens = itens
    }
    
    // MARK: - Functions
    
    func caclKgcal() -> Double {
        var total = 0.0
        for item in itens {
            total += item.kgcal
        }
        return total
    }
    
    // MARK: - NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(note, forKey: "note")
        coder.encode(itens, forKey: "itens")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        note = aDecoder.decodeInteger(forKey: "note")
        itens = aDecoder.decodeObject(forKey: "itens") as! [Item]
    }
}
