//
//  SWMovieInfoViewController.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import UIKit
import RealmSwift

class SWMovieInfoViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var episodeIDLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var crawlTextView: UITextView!
    @IBOutlet weak var charactersTable: UITableView!
    @IBOutlet weak var charactersSearch: UISearchBar!
    
    var numberOfMovie = 0
    
    let realm = try! Realm()
    var movies: Results<SWMovie>?
    var movie: SWMovie?
    
    var characters: Results<SWCharacter>?
    
    var charactersURLS: List<String>?
    var charactersNames: [String] = []
    var filteredNames: [String] = []
    var notFilteredNames: [String] = []
    
    var yOffSet = 0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCharactersTable()
        setupAutoscrollForCrawl()
        
        self.charactersTable.delegate = self
        self.charactersTable.dataSource = self
        self.charactersTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.charactersSearch.delegate = self
    }
    
    func setupUI() {
        self.movies = self.realm.objects(SWMovie.self)
        self.movie = movies![numberOfMovie]
        
        self.navigationItem.title = movie?.title
        self.episodeIDLabel.text = "Episode \((movie?.episodeID)!)"
        self.releaseDateLabel.text = "Release " + (movie?.releaseDate)!
        self.directorLabel.text = "Director " + (movie?.director)!
        self.crawlTextView.text = (movie?.crawl)!
    }
    
    func setupAutoscrollForCrawl(){
       timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        yOffSet += 10

        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.crawlTextView.contentOffset.y = CGFloat(self.yOffSet)
        })
    }
    
    func setupCharactersTable() {
        SWSwapiManager.getCharacter(page: "", success: {
            self.characters = self.realm.objects(SWCharacter.self)
            self.charactersURLS = self.movie?.characters
            self.getMoviesChar(charArray: self.charactersURLS!)
        }, fail: { error in
            print("ERROR: ", error)
        })
    }
    
    func getMoviesChar(charArray: List<String>){
        for char in charArray  {
          for swChar in self.characters! {
                if swChar.url == char {
                    self.charactersNames.append(swChar.name)
                }
            }
        }
       self.charactersTable.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension SWMovieInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.charactersNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.charactersTable.dequeueReusableCell(withIdentifier: "cell"))!
        
        let char = self.charactersNames[indexPath.row] as String
        cell.textLabel?.text = char
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWCharacterInfoViewController") as! SWCharacterInfoViewController
        vc.characterPrimaryKey = self.charactersNames[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SWMovieInfoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredNames = charactersNames.filter { $0.contains(searchText) }
            charactersNames = filteredNames
        } else {
            filteredNames = charactersNames
        }
        self.charactersTable.reloadData()
    }
}
