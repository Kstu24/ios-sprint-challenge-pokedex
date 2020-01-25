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
    var id: String
    var abilities: String
    var types: String
}
