//
//  PokedexController.swift
//  Pokedex
//
//  Created by Kevin Stewart on 1/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation

class APIController {

private let baseUrl = URL(string: "https://pokeapi.co/api/v2/")!

var chossenPokemon: Pokemon?

enum HTTPMethod: String {
    case get = "GET"
}
    
    enum NetworkError: Error {
        case noAuth
        case badAuth
        case otherError
        case badData
        case decodingError
    }
    

//func searchForPokemonWith(searchTerm: String, completion: @escaping () -> Void) {
//        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
//        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
//        urlComponents?.queryItems = [searchTermQueryItem]
//        
//        guard let requestURL = urlComponents?.url else {
//            print("Error: Request URL is nil!")
//            completion()
//            return
//        }
//        
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.get.rawValue
//        
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//            guard error == nil else {
//                print("Error fetching data: \(error)")
//                completion()
//                return
//            }
//            
//            guard let data = data else {
//                
//                print("Error: No data returned from data taks!")
//                completion()
//                return
//            }
//            print("data: \(String(data: data, encoding: .utf8))")
//
//            
//            let jsonDecoder = JSONDecoder()
//            do {
//                let pokemonSearch = try jsonDecoder.decode(PokemonSearch.self, from: data)
//                self.chossenPokemon = pokemonSearch.results
//            } catch {
//                print("Error: Unable to decode data into object of type [Pokemon]: \(error)")
//            }
//            completion()
//        }.resume()
//    }
    
    func gottaCatchemAll(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let allPokemonURL = baseUrl.appendingPathComponent("pokemon/\(searchTerm)")
        
        var request = URLRequest(url: allPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.badAuth))
                return
            }
            
            guard error == nil else {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            print(String(data: data, encoding: .utf8))
            let jsonDecoder = JSONDecoder()
            do {
                let pokemonSearch = try jsonDecoder.decode(Pokemon.self, from: data)
                self.chossenPokemon = pokemonSearch
                completion(.success(pokemonSearch))
                } catch {
                    print("Error: Unable to decode data into object of type [Pokemon]: \(error)")
                    completion(.failure(.otherError))
                }
        }.resume()
    }
    
    func savePokemon(pokemon: Pokemon) {
//        pokemon.append(pokemon)
    }

}
