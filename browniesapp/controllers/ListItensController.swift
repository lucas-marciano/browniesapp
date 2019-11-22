//
//  ListItensController.swift
//  browniesapp
//
//  Created by Lucas de Almeida Marciano on 20/11/19.
//  Copyright © 2019 Inatel. All rights reserved.
//

import UIKit

class ListItensController: UITableViewController, ViewControllerDelegate {
    // MARK: - Attributes
    
    var refeicoes: [Meal] = []
    
    // MARK: - Life cycle view
    
    override func viewDidLoad() {
        refeicoes = MealDao().load()
    }
    
    // MARK: - UITableViewController
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = refeicoes[indexPath.row].name
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showDetails))
        cell.addGestureRecognizer(longPress)
        return cell
    }
    
    // MARK: - Actions for the buttons
    
    func add(_ refeicao: Meal){
        refeicoes.append(refeicao)
        tableView.reloadData()
        
        let response = MealDao().save(refeicoes)
        
        if(!response){
            Alerts(self).showAlertError(message: "Ocorreu um erro ao tentar salvar.")
        }
    }
    
    @objc func showDetails(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began {
            let cell = gesture.view as! UITableViewCell
            guard let index = tableView.indexPath(for: cell) else { return }
            let meal = refeicoes[index.row]
            
            Alerts(self).showAlertRemove(meal: meal, handler: { alert in
                self.refeicoes.remove(at: index.row)
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: - UIStoryboardSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addMealSegue"){
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            }
        }
    }
}
