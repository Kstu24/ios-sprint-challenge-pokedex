//
//  PokedexController.swift
//  Pokedex
//
//  Created by Kevin Stewart on 1/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation

private let baseUrl = URL(string: "https://pokeapi.co/docs/v2.html")!

var pokemon: [Pokemon] = []

enum HTTPMethod: String {
    case get = "GET"
}

func searchForPokemonWith(searchTerm: String, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Error: Request URL is nil!")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error fetching data: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                
                print("Error: No data returned from data taks!")
                completion()
                return
            }
            print("data: \(String(data: data, encoding: .utf8))")

            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemonSearch = try jsonDecoder.decode(PokemonSearch.self, from: data)
                pokemon = pokemonSearch.results
            } catch {
                print("Error: Unable to decode data into object of type [Pokemon]: \(error)")
            }
            completion()
        }.resume()
    }

