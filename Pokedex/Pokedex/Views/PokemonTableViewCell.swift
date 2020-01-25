//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Kevin Stewart on 1/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet var pokemonLabel: UILabel!
    
    // MARK: - Methods

    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        pokemonLabel.text = pokemon.name
    }
    
    
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//


 }
