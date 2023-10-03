//
//  SWMovieInfoViewController.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import UIKit

protocol SWMovieInfoDisplayLogic: class {
    func display(characters: [SWCharacter])
    func displayEmptyList(with error: Error)
}

//TODO: use final, private etc
//TODO: change filtration for characters
class SWMovieInfoViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var episodeIDLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var crawlTextView: UITextView!
    @IBOutlet weak var charactersTable: UITableView!
    @IBOutlet weak var charactersSearch: UISearchBar!

    private var movie: SWMovie?
    private var characters: [SWCharacter] = []
    
    private var yOffSet = 0
    private var timer: Timer?

    private var interactor: SWMovieInfoInteractor?
    private var router: SWMovieInfoRouter?

    func setup(interactor: SWMovieInfoInteractor, movie: SWMovie) {
        self.interactor = interactor
        self.movie = movie
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.fetchCharacters()
        router = SWMovieInfoRouter(source: self)

        setupUI()
        setupAutoscrollForCrawl()
        setupTableView()

        charactersSearch.delegate = self
    }
    
    func setupUI() {
        guard let movie = movie else { return }
        
        navigationItem.title = movie.title
        episodeIDLabel.text = "Episode \(movie.episode_id)"
        releaseDateLabel.text = "Release " + movie.release_date
        directorLabel.text = "Director " + movie.director
        crawlTextView.text = movie.opening_crawl
    }
    

    func setupTableView() {
        charactersTable.delegate = self
        charactersTable.dataSource = self
        charactersTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupAutoscrollForCrawl() {
       timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        yOffSet += 10

        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.crawlTextView.contentOffset.y = CGFloat(self.yOffSet)
        })
    }

}

extension SWMovieInfoViewController: SWMovieInfoDisplayLogic {
    
    func display(characters: [SWCharacter]) {
        self.characters = characters
        self.charactersTable.reloadData()
        //self.charactersURLS = self.movie?.characters
        //self.getMoviesChar(charArray: self.charactersURLS!)
    }
    
    func displayEmptyList(with error: Error) {
        //TODO: empty state
    }

    //TODO: filtered related characters for moview
    func getMoviesChar(charArray: [String]){
        for char in charArray  {
          for swChar in self.characters {
                if swChar.url == char {
                    //self.charactersNames.append(swChar.name)
                }
            }
        }
       self.charactersTable.reloadData()
    }

}

// MARK: - UITableViewDataSource
extension SWMovieInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: rewrite table view cell
        let cell:UITableViewCell = (self.charactersTable.dequeueReusableCell(withIdentifier: "cell"))!
        
        let char = characters[indexPath.row].name
        cell.textLabel?.text = char
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.showCharacterInfo(for: characters[indexPath.row])
    }
}

// MARK: - UISearchBarDelegate
extension SWMovieInfoViewController: UISearchBarDelegate {
    //TODO: rewrite
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /*if searchText != "" {
            filteredNames = charactersNames.filter { $0.contains(searchText) }
            charactersNames = filteredNames
        } else {
            filteredNames = charactersNames
        }*/
        charactersTable.reloadData()
    }
}
