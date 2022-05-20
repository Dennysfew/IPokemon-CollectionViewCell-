//
//  Pokemon.swift
//  IPokemon
//
//  Created by Denys on 15.04.2022.
//

import Foundation

struct Pokemon: Codable {
    var id: Int {
        let url = URL(string: url)
        return Int(url?.lastPathComponent ?? "") ?? 0
    }
    var name: String
    var url: String
    var pokemonDetails: PokemonSelected?
}

struct Pokemons: Codable{
    var results: [Pokemon]
}








