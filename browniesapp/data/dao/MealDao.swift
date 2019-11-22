//
//  MealDao.swift
//  browniesapp
//
//  Created by Lucas de Almeida Marciano on 22/11/19.
//  Copyright © 2019 Inatel. All rights reserved.
//

import Foundation

class MealDao{
    
    // MARK: - DAO Functions
    
    func save(_ meals: [Meal]) -> Bool {
        guard let path = recoverPath() else { return false }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
            try data.write(to: path)
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    func load() -> [Meal] {
        guard let path = recoverPath() else { return [] }
        
        do {
            let data = try Data(contentsOf: path)
            guard let savedMeals = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Meal] else { return [] }
            return savedMeals
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    // MARK: - Functions
       
    func recoverPath() -> URL? {
        guard let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let path = folder.appendingPathComponent("meals")
        return path
    }
}
