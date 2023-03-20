//
//  pokemonController.swift
//  Pokedex
//
//  Created by Michiel Spiritus on 14/03/2023.
//

import Foundation
import UIKit

public struct Pokemon: Codable,Identifiable {
    public let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
 
}


public struct Sprites: Codable {
    let frontDefault: String
}

public struct TypeElement: Codable {
    let slot: Int
    let type: TypeClass
}

public struct TypeClass: Codable {
    let name: String
}

public struct pokemonList: Codable {
    var pokemon: [Pokemon]
}


public func fetchPokemonList(completion: @escaping ([Pokemon]) -> Void) {
    let url = URL(string: "https://stoplight.io/mocks/appwise-be/pokemon/57519009/pokemon")!

    // Create a URLSession object
    let session = URLSession.shared

    // Create a data task to fetch the JSON data
    let task = session.dataTask(with: url) { data, response, error in
        // Check for errors and unwrapping the optional values
        guard let jsonData = data, error == nil else {
            print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            return
        }

        do { // Parse the JSON data into an array of Pokemon structs
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            var pokemonData = try decoder.decode([Pokemon].self, from: jsonData)
            
            // Call the completion handler with the fetched data
            completion(pokemonData)
            print(pokemonData.count)
        } catch {
            print("Error parsing JSON data: \(error.localizedDescription)")
        }
    }

    // Start the data task
    task.resume()
}

class Favorites: ObservableObject, RandomAccessCollection {
    
    typealias Element = Pokemon
    typealias Index = Int
    
    @Published var pokemonsList: [Pokemon] = []
    
    var startIndex: Int { pokemonsList.startIndex }
    var endIndex: Int { pokemonsList.endIndex }
    
    subscript(position: Int) -> Pokemon {
        return pokemonsList[position]
    }
    
    func index(after i: Int) -> Int {
        return pokemonsList.index(after: i)
    }
    
    func index(before i: Int) -> Int {
        return pokemonsList.index(before: i)
    }
    
    func add(_ pokemon: Pokemon) {
        pokemonsList.append(pokemon)
        print("Added")
    }
    
    func remove(_ pokemon: Pokemon) {
        print("Removed")
        pokemonsList.removeAll(where: { $0.id == pokemon.id })
    }
}


class Team: ObservableObject, RandomAccessCollection {
    
    typealias Element = Pokemon
    typealias Index = Int
    
    @Published var pokemonsList: [Pokemon] = []
    
    var startIndex: Int { pokemonsList.startIndex }
    var endIndex: Int { pokemonsList.endIndex }
    
    subscript(position: Int) -> Pokemon {
        return pokemonsList[position]
    }
    
    func index(after i: Int) -> Int {
        return pokemonsList.index(after: i)
    }
    
    func index(before i: Int) -> Int {
        return pokemonsList.index(before: i)
    }
    
    func add(_ pokemon: Pokemon) {
        pokemonsList.append(pokemon)
        print("Added")
    }
    
    func remove(_ pokemon: Pokemon) {
        print("Removed")
        pokemonsList.removeAll(where: { $0.id == pokemon.id })
    }
}
