//
//  DetailViewController.swift
//  PokemonByCollection
//
//  Created by Denys on 14.05.2022.
//

import UIKit
import Kingfisher
class DetailViewController: UIViewController {
    @IBOutlet var pokemonSprite: UIImageView!
    @IBOutlet var pokemonName: UILabel!
    @IBOutlet var pokemonWeight: UILabel!
    @IBOutlet var pokemonHight: UILabel!
    let apiService: APIService = APIService()
    
    var pokemon: Pokemon?
    
    var pokemonSelected: PokemonSelected? {
        didSet{
            
            guard let pokemonName = pokemonSelected?.name else { return }
            guard let pokemonWeight = pokemonSelected?.weight else { return }
            guard let pokemonHeight = pokemonSelected?.height else { return }
            
            DispatchQueue.main.async {
                self.pokemonName.text = String(pokemonName)
                self.pokemonWeight.text = String(pokemonWeight)
                self.pokemonHight.text = String(pokemonHeight)
                
            }
            
            guard let imageUrl = pokemonSelected?.sprites.front_default else { return }
            
            let resource = ImageResource(downloadURL: URL(string: imageUrl)!, cacheKey: imageUrl)
            pokemonSprite?.kf.setImage(with: resource)
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    
        

        guard let pokemon = pokemon else { return }
        
        apiService.fetchData(urlString: pokemon.url) { [weak self] value in
            guard let data = value else { return }
            
            do {
                
                let pokemonSelected = try JSONDecoder().decode(PokemonSelected.self, from: data)
                
                DispatchQueue.main.async {
                    
                    self?.pokemonSelected = pokemonSelected
                    
                }
            }
            catch {
                print(error)
                return
            }
        }
        
    }
    


}
