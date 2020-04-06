//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Kevin Stewart on 1/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit

class PokemonSearchDetailViewController: UIViewController {
    
    // MARK: - Properties
    var newPokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    var apiController: APIController? {
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
    @IBOutlet var deleteButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func savePokemonTapped(_ sender: UIButton) {
        guard let pokemon = newPokemon else { return }
        apiController?.addPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func deletePokemonTapped(_ sender: UIButton) {
        guard let pokemon = newPokemon else { return }
        apiController?.delete(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Function
    
    func hideKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func updateViews() {
  guard isViewLoaded else { return }
            guard let pokemonObject = newPokemon else { return }
            title = pokemonObject.name.capitalized
            nameLabel.text = pokemonObject.name.capitalized
            idLabel.text = "ID: \(pokemonObject.id)"
            
            var types: [String] = []
            for typeInfo in pokemonObject.types {
                types.append(typeInfo.type.name)
            }
            
            typesLabel.text = "Types: \(types.joined(separator: ", "))"
            abilitiesLabel.text = "Abilities: \(pokemonObject.abilities[0].ability.name.capitalized)"
            
        apiController?.fetchImage(from: pokemonObject.sprites.frontShiny, completion: { (pokemonImage) in
                DispatchQueue.main.async {
                    self.imageView.image = pokemonImage
                }
            })
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

extension PokemonSearchDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        print("Searching for \(searchTerm)...")
        apiController?.searchForPokemonDetails(searchTerm: searchTerm) { (pokemonObject) in
            guard let pokemon = try? pokemonObject.get() else { return }
            DispatchQueue.main.async {
                self.newPokemon = pokemon
            }
        }
        guard let pokemonImageUrl = newPokemon?.sprites.frontShiny else {return}
        apiController?.fetchImage(from: pokemonImageUrl, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
    }
}

