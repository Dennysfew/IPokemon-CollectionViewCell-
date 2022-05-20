//
//  PokemonCollectionViewCell.swift
//  PokemonByCollection
//
//  Created by Denys on 14.05.2022.
//

import UIKit
import Kingfisher
class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var pokemonNameLbl: UILabel!
    @IBOutlet var pokemonImageView: UIImageView!
    
    func setup(with pokemonSelected: PokemonSelected) {
      
        pokemonNameLbl.text = pokemonSelected.name
        let imageUrl = pokemonSelected.sprites.front_default
        
        let resource = ImageResource(downloadURL: URL(string: imageUrl)!, cacheKey: imageUrl)
        pokemonImageView?.kf.setImage(with: resource)
    }
    
   
}
