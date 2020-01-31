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
        return pokedexController.chossenPokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }

//        cell.pokedexController.chossenPokemon = pokedexController.savePokemon(pokemon: [indexPath.row])
        
        cell.pokemonLabel.text = pokedexController.chossenPokemon[indexPath.row].name

         return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "PokemonSearchSegue" {
            guard let pokedexVC = segue.destination as? PokedexTableViewController else { return }

            pokedexVC.pokedexController = pokedexController
        }

    }
    

}
