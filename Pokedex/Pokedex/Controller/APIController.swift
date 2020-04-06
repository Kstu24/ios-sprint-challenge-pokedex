//
//  PokedexController.swift
//  Pokedex
//
//  Created by Kevin Stewart on 1/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case push = "PUSH"
}
    
enum NetworkError: Error {
        case noData
        case otherError
        case decodingError
    }

class APIController {

let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/")
var pokemonArray: [Pokemon] = []
var pokemonImages: [URL] = []
    
    // MARK: - Fetching Pokemon
func searchForPokemonDetails(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
    let searchPokemonURL = baseUrl?.appendingPathComponent(searchTerm.lowercased())
    guard let pokeUrl = searchPokemonURL else { return }
    var request = URLRequest(url: pokeUrl)
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
    
    
    // MARK: - Fetching image
    func fetchImage(from imageURL: String, completion: @escaping(UIImage?) -> Void) {
        guard let imageURL = URL(string: imageURL) else {
            completion(nil)
            return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (imageData, _, error) in
            
            if let error = error {
                
                NSLog("Error fetching image: \(error)")
                return
            }
            
            guard let data = imageData else {
                NSLog("No data provided for image: \(imageURL)")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    //MARK: - Pokemon Methods
    
    func addPokemon(pokemon: Pokemon) {
        pokemonArray.append(pokemon)
    }

     func delete(pokemon: Pokemon) {
        guard let index = pokemonArray.firstIndex(of: pokemon) else { return }
        pokemonArray.remove(at: index)
    }
    
}
