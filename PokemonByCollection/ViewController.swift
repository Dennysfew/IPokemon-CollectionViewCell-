//
//  ViewController.swift
//  PokemonByCollection
//
//  Created by Denys on 13.05.2022.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
    var pokemons = [Pokemon]()
    let apiService: APIService = APIService()
    
    var pokemonSelected = [PokemonSelected]() {
        
        didSet {
            DispatchQueue.main.async {
             self.collectionView.reloadData()
            }
            
        }
    }

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iPokemon"
//        collectionView.dataSource = self
//        collectionView.delegate = self
      collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let urlStringMain = "https://pokeapi.co/api/v2/pokemon?limit=135"
        
        apiService.fetchData(urlString: urlStringMain) { [weak self] value in
            
            guard let data = value else { return }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemons.self, from: data)
                
                pokemon.results.forEach({
                    self?.apiService.fetchData(urlString: $0.url) { [weak self] value in
                        guard let data = value else { return }
                        
                        do {
                            
                            let pokemonSelected = try JSONDecoder().decode(PokemonSelected.self, from: data)
                            self?.pokemonSelected.append(pokemonSelected)
                        }
                        catch {
                            print(error)
                            return
                        }
                    }
                })
                
                DispatchQueue.main.async {
                    
                    self?.pokemons = pokemon.results
                    self?.collectionView.reloadData()
                }
            }
            catch {
                print(error)
                return
            }
        }
        
    }
    
        
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as! PokemonCollectionViewCell
        guard indexPath.row < pokemonSelected.count else { return cell }
        cell.setup(with:pokemonSelected[indexPath.row] )
        
        print(pokemons[indexPath.row].id)


        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 3) - 6, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.pokemon = pokemons[indexPath.row]
        show(vc, sender: true)
      
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//                vc.pokemon = pokemons[indexPath.row]
//    }
    
    
    
    
    }

// MARK: - UICollectionViewDelegate



