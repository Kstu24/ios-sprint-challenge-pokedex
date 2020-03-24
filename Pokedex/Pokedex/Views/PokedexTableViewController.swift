//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Kevin Stewart on 1/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    private var pokedexController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokedexController.pokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }

//        cell.pokedexController.chossenPokemon = pokedexController.savePokemon(pokemon: [indexPath.row])
        
        cell.pokemonLabel.text = pokedexController.pokemon[indexPath.row].name

         return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "PokemonSearchSegue" {
            guard let pokedexSearchVC = segue.destination as? PokedexTableViewController else { return }

            pokedexSearchVC.pokedexController = pokedexController
        } else if segue.identifier == "PokemonDetailSegue" {
        guard let pokedexDetailVC = segue.destination as? PokemonDetailViewController else { return }

        pokedexDetailVC.pokedexController = pokedexController

    }
    

    }
}
