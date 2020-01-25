//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Kevin Stewart on 1/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit



class PokemonSearchViewController: UIViewController {
    
    // MARK: - Properties
    private var apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet var searchBar: UISearchBar!
//    @IBOutlet var pokemonSearchSprite: SKView!

    
    
    
    
    // MARK: - Actions
    @IBAction func savePokemonTapped(_ sender: UIButton) {
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        print("Searching for \(searchTerm)...")
        apiController.searchForPokemonWith(searchTerm: searchTerm) {
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }
        }
            
        }
}

