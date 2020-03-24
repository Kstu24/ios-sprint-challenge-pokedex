//
//  PokedexController.swift
//  Pokedex
//
//  Created by Kevin Stewart on 1/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation

class APIController {

private let baseUrl = URL(string: "https://pokeapi.co")!
var pokemon: [Pokemon] = []
var choosenPokemon: Pokemon?

enum HTTPMethod: String {
    case get = "GET"
}
    
    enum NetworkError: Error {
        case noData
        case otherError
        case decodingError
    }
    

func searchForPokemonDetails(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
    let searchPokemonURL = baseUrl.appendingPathComponent("/api/v2/pokemon/\(searchTerm)")
        var request = URLRequest(url: searchPokemonURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error fetching data: \(error!)")
                completion(.failure(.noData))
                return
            }
            guard let data = data else {
                print("Error: No data returned from data taks!")
                completion(.failure(.noData))
                return
            }
            do {
                let pokemonSearch = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonSearch))
            } catch {
                print("Error: Unable to decode data into object of type [Pokemon]: \(error)")
            }
            completion(.failure(.decodingError))
        }.resume()
    }
}
