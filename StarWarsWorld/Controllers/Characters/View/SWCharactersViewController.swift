//
//  SWCharactersViewController.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import UIKit

protocol SWCharactersDisplayLogic: class {
    func display(characters: [SWCharacter])
    func displayEmptyList()
}

class SWCharactersViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var charactersTable: UITableView!
    @IBOutlet weak var searchInCharacters: UISearchBar!
    
    var characters: [SWCharacter] = []
    
    private var interactor: SWCharactersInteractorLogic?
    private var router: SWCharactersRouterLogic?

    func setup(interactor: SWCharactersInteractorLogic) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.fetchCharacters()
        router = SWCharactersRouter(source: self)

        addDismissKeyboardTap()

        charactersTable.delegate = self
        charactersTable.dataSource = self
        charactersTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        searchInCharacters.delegate = self
    }

    func addDismissKeyboardTap() {
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

extension SWCharactersViewController: SWCharactersDisplayLogic {
    
    func display(characters: [SWCharacter]) {
        self.characters = characters
        charactersTable.reloadData()
    }
    
    func displayEmptyList() {
        characters = []
        charactersTable.reloadData()
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
        router?.showCharacterInfo(for: characters[indexPath.row])
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
