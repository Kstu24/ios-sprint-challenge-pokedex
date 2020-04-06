//
//  Pokemon.swift
//  Pokedex
//
//  Created by Kevin Stewart on 1/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation


struct Pokemon: Codable, Equatable {
    var name: String
    var id: Int
    var types: [TypeInfo]
    var abilities: [AbilityInfo]
    var sprites: PokemonSprites
    
    struct AbilityInfo: Codable, Equatable {
        var ability: Ability
        
        struct Ability: Codable, Equatable {
               var name: String
           }
    }
   
    struct TypeInfo: Codable, Equatable {
        var type: TypieType
        
        struct TypieType: Codable, Equatable {
            var name: String
        }

    }
    
    struct PokemonSprites: Codable,Equatable {
        var frontShiny: String

        enum CodingKeys: String, CodingKey {
            case frontShiny = "front_default"
        }
    }
}
