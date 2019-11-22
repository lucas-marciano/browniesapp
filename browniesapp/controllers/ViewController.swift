//
//  ViewController.swift
//  browniesapp
//
//  Created by Lucas de Almeida Marciano on 18/11/19.
//  Copyright © 2019 Inatel. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate {
    func add(_ refeicao: Meal)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddItensDelegate {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var nameTf: UITextField?
    @IBOutlet weak var noteTf: UITextField?
    @IBOutlet weak var tableItensTableView: UITableView?
    
    // MARK: - Attributes
    
    var delegate: ViewControllerDelegate?
    var itens: [Item] = []
    var selectedItens: [Item] = []
    
    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        let btAddItem = UIBarButtonItem(title: "Add Item", style: .plain, target: self, action: #selector(addItemInList))
        navigationItem.rightBarButtonItem = btAddItem
        itens = ItemDao().load()
    }
    
    // MARK: - IBAction
    
    @IBAction func add(_ sender: Any) {
        if let meal = recoverMealForm() {
            delegate?.add(meal)
            navigationController?.popViewController(animated: true)
        } else {
            Alerts(self).showAlertError(with: "Atenção", message: "Não foi possívle inserir a refeição, verifique o formulário.")
        }
        
    }
    
    // MARK: - Button Actions
    
    @objc func addItemInList(){
        let addItemViewController = AddItensViewController(delegate: self)
        navigationController?.pushViewController(addItemViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        tableItensTableView?.reloadData()
        
        let response = ItemDao().save(itens)
        if !response {
            Alerts(self).showAlertError(message: "Ocorreu um erro ao salvar os itens.")
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = itens[indexPath.row].name
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if(cell.accessoryType == .none){
            cell.accessoryType = .checkmark
            selectedItens.append(itens[indexPath.row])
        } else {
            cell.accessoryType = .none
            let item = itens[indexPath.row]
            if let position = selectedItens.firstIndex(of: item) {
                selectedItens.remove(at: position)
            }
        }
    }
    
    // MARK: - Functions
    
    func recoverMealForm() -> Meal? {
        if let name = nameTf?.text, let note = noteTf?.text {
            if let note = Int(note) {
                return Meal(name: name, note: note, itens: selectedItens)
            }
        }
        return nil
    }
}
