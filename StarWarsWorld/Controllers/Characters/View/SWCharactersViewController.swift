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
    
    var characters: [SWCharacter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCharactersTable()
        addDismissKeyboardTap()

        charactersTable.delegate = self
        charactersTable.dataSource = self
        charactersTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        searchInCharacters.delegate = self
    }
    
    func setupCharactersTable() {
        
        /*SWSwapiManager.getCharacters(success: { chatacters in
            self.characters = chatacters
            self.charactersTable.reloadData()
        }, fail: { error in
            print("ERROR: ", error)
        })*/
    }
    
    func addDismissKeyboardTap() {
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension SWCharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (charactersTable.dequeueReusableCell(withIdentifier: "cell"))!
        
        let character = characters[indexPath.row]
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = character.name
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWCharacterInfoViewController") as! SWCharacterInfoViewController
        vc.currentCharacter = characters[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SWCharactersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            let namesBeginningWithLetterPredicate = NSPredicate(format: "name BEGINSWITH[cd] %@", searchText)
           // self.characters = realm.objects(SWCharacter.self).filter(namesBeginningWithLetterPredicate)
        } else {
            //self.characters =
        }
        charactersTable.reloadData()
    }
}
