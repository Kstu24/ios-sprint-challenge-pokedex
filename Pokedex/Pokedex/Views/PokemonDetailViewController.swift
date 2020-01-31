//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Kevin Stewart on 1/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Outlets
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    
    
    
    // MARK: - Function
    
    func updateViews() {
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            typesLabel.text = pokemon.types
            abilitiesLabel.text = pokemon.abilities
            navigationItem.title = pokemon.name
        }
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "PokemonDetailSegue" {
            guard let pokemonDetailVC = segue.destination as? PokemonDetailViewController else { return }

            pokemonDetailVC.pokemon = pokemon
        }

    }

}
