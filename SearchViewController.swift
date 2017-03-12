//
//  SearchViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    var pokemonArray: [Pokemon] = []
    var filteredArray: [Pokemon] = []
    
    override func viewDidLoad() {
        searchOutlet.dataSource = self
        searchOutlet.delegate = self//UICollectionViewDelegate = self
        //CVCoutlet
        super.viewDidLoad()
        pokemonArray = PokemonGenerator.getPokemonArray()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var searchOutlet: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return PokemonGenerator.categoryDict.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let temp = collectionView
        
        let temp = collectionView.dequeueReusableCell(withReuseIdentifier: "viewCellReuse", for: indexPath) as? collectionviewcell
        let cellString = PokemonGenerator.categoryDict[indexPath.item ]
        temp?.imageView.image = UIImage(named: cellString!)
        return temp!
        
      // return PokemonGenerator.categoryDict
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     //let temp = [Pokemon]
        
    /*
 In didSelectItemAt you'll need to implement the following functionality:
 Use the filteredPokemon(ofType type: Int) function to get an array of Pokemon belonging to the selected category (based off the cell the user selected).
 Then perform a segue to CategoryViewController using the identifier you created in Part 1. (Though we've only gone over triggering segues in Storyboard by control-dragging from a button, you can trigger a segue that you created in Storyboard between two view controllers programmatically by calling the following method in your code: performSegue(withIdentifier: <YourSegueIdentifierFromStoryboard>, sender: <Any?>)
 */
        filteredArray = filteredPokemon(ofType: indexPath.row)
        performSegue(withIdentifier: "searchToCategory", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "searchToCategory" {
        let destination = segue.destination as? CategoryViewController
        destination?.pokemonArray = filteredArray
        }
    }
    
    // Utility function to iterate through pokemon array for a single category
    func filteredPokemon(ofType type: Int) -> [Pokemon] {
        var filtered: [Pokemon] = []
        for pokemon in pokemonArray {
            if (pokemon.types.contains(PokemonGenerator.categoryDict[type]!)) {
                filtered.append(pokemon)
            }
        }
        return filtered
    }


}
