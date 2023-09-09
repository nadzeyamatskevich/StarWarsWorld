//
//  SWMovieInfoViewController.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import UIKit

class SWMovieInfoViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var episodeIDLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var crawlTextView: UITextView!
    @IBOutlet weak var charactersTable: UITableView!
    @IBOutlet weak var charactersSearch: UISearchBar!

    var movie: SWMovie?
    
    var characters: [SWCharacter] = []
    
    var charactersURLS: [String] = []
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
        setupTableView()

        self.charactersSearch.delegate = self
    }
    
    func setupUI() {
        self.navigationItem.title = movie?.title
        self.episodeIDLabel.text = "Episode \((movie?.episode_id)!)"
        self.releaseDateLabel.text = "Release " + (movie?.release_date)!
        self.directorLabel.text = "Director " + (movie?.director)!
        self.crawlTextView.text = (movie?.opening_crawl)!
    }

    func setupTableView() {
        self.charactersTable.delegate = self
        self.charactersTable.dataSource = self
        self.charactersTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        SWSwapiManager.getCharacter(success: { characters in
            self.characters = characters
            self.charactersTable.reloadData()
            //self.charactersURLS = self.movie?.characters
            //self.getMoviesChar(charArray: self.charactersURLS!)
        }, fail: { error in
            print("ERROR: ", error)
        })
    }
    
    func getMoviesChar(charArray: [String]){
        for char in charArray  {
          for swChar in self.characters {
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
            return charactersNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.charactersTable.dequeueReusableCell(withIdentifier: "cell"))!
        
        let char = charactersNames[indexPath.row]
        cell.textLabel?.text = char
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.textColor = UIColor.white
        
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
