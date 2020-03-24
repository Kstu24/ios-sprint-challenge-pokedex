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

struct Pokemon: Decodable {
    var name: String
    var id: Int
    var type: PokemonType
    var abilities: PokemonAbility
    var sprites: Sprites
    
    struct Ability: Decodable {
        var pokemonAbility: PokemonAbility
    }
    struct PokemonAbility: Decodable {
        var name: String
    }
    struct Types: Decodable {
        var pokemonType: PokemonType
    }
    struct PokemonType: Decodable {
        var name: String
    }
    
    struct Sprites: Decodable {
        var frontShiny: String
        
        enum CodingKeys: String, CodingKey {
            case frontShiny = "front_shiny"
        }
    }
}
