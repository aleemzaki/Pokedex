//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemonArray!.count
        //return PokemonGenerator.categoryDict.count
    
    }
    var PN = Int()
    var AN = Int()
    var DN = Int()
    var HN = Int()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let temp = tableView.dequeueReusableCell(withIdentifier: "viewCellReuse", for: indexPath) as? categoryviewcell
        
        let pokemon = pokemonArray?[indexPath.item]
        //let str = x != nil ? "\(x!)" : ""
        //let strPokeNum = "\(pokemon?.number)"
        PN = (pokemonArray?[indexPath.item].number)!
        temp?.pokeNum.text = String(PN)
        AN = (pokemonArray?[indexPath.item].attack)!
        DN = (pokemonArray?[indexPath.item].defense)!
        HN = (pokemonArray?[indexPath.item].health)!

        temp?.pokeStats.text = String(AN)+"/"+String(DN)+"/"+String(HN)
        temp?.pokeName.text = pokemonArray?[indexPath.item].name
        
        if let image = cachedImages[indexPath.row] {
            temp?.pokeImage.image = image // may need to change this!
            
        } else {
            let url = URL(string: (pokemon?.imageUrl)!)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.cachedImages[indexPath.row] = image
                            temp?.pokeImage.image = UIImage(data: imageData) // may need to change this!
                            
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code")
                    }
                }
            }
            downloadPicTask.resume()
        }
        return temp!
        /*let temp = tableView.dequeueReusableCell(withIdentifier: "viewCellReuse", for: indexPath) as? categoryviewcell
        _ = pokemonArray?[indexPath.item ]
        temp?.imageView.image = UIImage(named: _!)
        return temp!*/
        
    }
    
    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        
        performSegue(withIdentifier: "categoryToInfo", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        
        
        if segue.identifier == "categoryToInfo" {
            let destination = segue.destination as? PokemonInfoViewController
            destination?.pokemon = pokemonArray?[(selectedIndexPath?.row)!]
            destination?.image = cachedImages[(selectedIndexPath?.row)!]
        }
    }
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!

}
