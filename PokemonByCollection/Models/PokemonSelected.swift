//
//  PokemonSelected.swift
//  IPokemon
//
//  Created by Denys on 15.04.2022.
//

import Foundation

struct PokemonSelected: Codable {
    
    var sprites: PokemonSprites
    var weight: Int
    var height: Int
    var name: String
}

struct PokemonSprites: Codable{
    var front_default: String
}


