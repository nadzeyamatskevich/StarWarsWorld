# StarWarsWorld

This is my technical task from the interview 2018. After 5 years I decided to rewrite this code with my updated experience. 

Done: 
+ Update project to new Xcode version
+ Delete Realm
+ Refactor code mistakes like force unwrap etc.

In Progress:
- Integrate CoreData
- Moving to Clean Swift Architecture
- Unit tests
- Functional tests on Python



Technical task description: 
StarWars API
 
There is an SW API, available for free https://swapi.co/documentation . Create an iOS app, using Swift4, that will properly integrate with it and will provide the following features:
 
- app has 2 main tabs: Movies & Search
 
-- Movies tab contains list of SW movies
--- when selecting a movie, it displays Movie info screen
-- Search tab provides UI for searching SW characters only
--- all search results must be segmented by entity type
 
-- Movie info screen contains 2 segments:  Info and Characters
--- Info segment provides the following information: title, episode id, release date, director, auto-scrollable crawl
--- Characters segment provides list of characters, appeared in this movie; (you can drag a search bar from the top of the list, for fast-filtering characters)
--- when selecting a Character from the list, a Character info screen is displayed
 
-- Character info screen provides the following information: Name, gender, birth date, birth, home world, species, related movies
--- when selecting a home-world item, it displays Planet info screen
--- when selecting an item from related movies section - it displays a Movie info screen
 
 
-- Planet info screen provides the following information: name, population, climate, diameter, terrain
