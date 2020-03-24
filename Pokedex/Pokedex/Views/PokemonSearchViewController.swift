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
    var newPokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    
    
    
    
    // MARK: - Actions
    @IBAction func savePokemonTapped(_ sender: UIButton) {
        guard let pokemon = newPokemon else { return }
        apiController.pokemon.append(pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Function
    
    func updateViews() {
        if let pokemon = newPokemon {
            nameLabel.text = pokemon.name
            idLabel.text = "ID: \(pokemon.id)"
            typesLabel.text = "Types: \(pokemon.type)"
            abilitiesLabel.text = "Abilities: \(pokemon.abilities)"
            navigationItem.title = pokemon.name
        } else {
            return
        }
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
        apiController.searchForPokemonDetails(searchTerm: searchTerm) {_ in 
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
}

