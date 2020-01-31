//
//  Pokemon.swift
//  Pokedex
//
//  Created by Kevin Stewart on 1/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation

struct PokemonSearch: Decodable {
    let results: [Pokemon]
}


struct Pokemon: Codable {
    var name: String
    var id: Int
    var abilities: String
    
    struct Ability: Codable {
        var pokemonAbility: PokemonAbility
    }
    struct PokemonAbility: Codable {
        var name: String
    }
    var types: String
    
    struct Types: Codable {
        var pokemonType: PokemonType
    }
    struct PokemonType: Codable {
        var name: String
    }
    
    var sprites: Sprites
    struct Sprites: Codable {
        var shiny: String
    }
}
