//
//  AddItensViewController.swift
//  browniesapp
//
//  Created by Lucas de Almeida Marciano on 21/11/19.
//  Copyright © 2019 Inatel. All rights reserved.
//

import UIKit

protocol AddItensDelegate {
    func add(_ item: Item)
}

class AddItensViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var kgcalTextField: UITextField?
    
    // MARK: - Delegates
    var delegate: AddItensDelegate?
    
    // MARK: - Constructor
    init(delegate: AddItensDelegate){
        super.init(nibName: "AddItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDcoder: NSCoder) {
        super.init(coder: aDcoder)
    }
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    @IBAction func addItem(_ sender: UIButton) {
        
        guard let name = nameTextField?.text else { return }
        guard let kgcalS = kgcalTextField?.text else { return }
        guard let kgcal: Double = Double(kgcalS) else { return }
        
        let item = Item(name: name, kgcal: kgcal)
        delegate?.add(item)
        navigationController?.popViewController(animated: true)
    }
    
}
