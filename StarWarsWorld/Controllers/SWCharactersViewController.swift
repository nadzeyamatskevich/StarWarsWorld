//
//  SWCharactersViewController.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import UIKit

class SWCharactersViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var charactersTable: UITableView!
    @IBOutlet weak var searchInCharacters: UISearchBar!
    
    var chatacters: [SWCharacter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCharactersTable()
        addDismissKeyboardTap()

        self.charactersTable.delegate = self
        self.charactersTable.dataSource = self
        self.charactersTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.searchInCharacters.delegate = self
    }
    
    func setupCharactersTable() {
        
        SWSwapiManager.getCharacter(success: { chatacters in
            self.chatacters = chatacters
            self.charactersTable.reloadData()
        }, fail: { error in
            print("ERROR: ", error)
        })
    }
    
    func addDismissKeyboardTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension SWCharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.charactersTable.dequeueReusableCell(withIdentifier: "cell"))!
        
        let character = chatacters[indexPath.row]
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = character.name
        
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SWCharactersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            let namesBeginningWithLetterPredicate = NSPredicate(format: "name BEGINSWITH[cd] %@", searchText)
           // self.chatacters = realm.objects(SWCharacter.self).filter(namesBeginningWithLetterPredicate)
        } else {
            //self.chatacters =
        }
        self.charactersTable.reloadData()
    }
}
