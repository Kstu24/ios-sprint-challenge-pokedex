//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Kevin Stewart on 1/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let apiController = APIController()
    var pokemon: Pokemon! {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.pokemonArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        let pokemonCharacter = apiController.pokemonArray[indexPath.row]
        cell.textLabel?.text = pokemonCharacter.name
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "PokemonSearchSegue" {
           if let pokemonSearchVC = segue.destination as? PokemonSearchDetailViewController {
               pokemonSearchVC.apiController = apiController
           }
        } else if segue.identifier == "PokemonDetailSegue" {
        guard let pokedexDetailVC = segue.destination as? PokemonSearchDetailViewController,
        let indexPath = tableView.indexPathForSelectedRow else { return }
        pokedexDetailVC.newPokemon = apiController.pokemonArray[indexPath.row]
        pokedexDetailVC.apiController = apiController
            

    }
    

    }
}
