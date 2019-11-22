//
//  ItemDao.swift
//  browniesapp
//
//  Created by Lucas de Almeida Marciano on 22/11/19.
//  Copyright © 2019 Inatel. All rights reserved.
//

import Foundation

class ItemDao {
    // MARK: - DAO Functions
    
    func save(_ itens: [Item]) -> Bool {
        guard let path = recoverPath() else { return false }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            try data.write(to: path)
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    func load() -> [Item] {
        guard let path = recoverPath() else { return [] }
        
        do {
            let data = try Data(contentsOf: path)
            guard let savedItens = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Item] else { return [] }
            return savedItens
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    // MARK: - Functions
       
    func recoverPath() -> URL? {
        guard let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let path = folder.appendingPathComponent("itens")
        return path
    }
}
