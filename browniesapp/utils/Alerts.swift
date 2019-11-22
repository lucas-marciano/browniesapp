//
//  Alerts.swift
//  browniesapp
//
//  Created by Lucas de Almeida Marciano on 21/11/19.
//  Copyright © 2019 Inatel. All rights reserved.
//

import UIKit

class Alerts {
    
    let uiViewController: UIViewController
    
    init(_ uiViewController: UIViewController){
        self.uiViewController = uiViewController
    }
    
    func showAlertError(with title: String = "Atenção", message: String){
        let btCancel = UIAlertAction(title: "Fechar", style: .cancel)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(btCancel)
        uiViewController.present(alert, animated: true, completion: nil)
    }
    
    func showAlertRemove(meal: Meal, handler: @escaping (UIAlertAction) -> Void) {
        let btCancel = UIAlertAction(title: "Fechar", style: .cancel)
        let btDelete = UIAlertAction(title: "Apagar", style: .destructive, handler: handler)
        let alert = UIAlertController(title: meal.name, message: "Nota: \(meal.note)", preferredStyle: .alert)
        
        alert.addAction(btCancel)
        alert.addAction(btDelete)
        
        uiViewController.present(alert, animated: true, completion: nil)
    }
}
