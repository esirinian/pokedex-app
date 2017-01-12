//
//  PokeCell.swift
//  Pokedex
//
//  Created by Eric Sirinian on 1/11/17.
//  Copyright © 2017 Eric Sirinian. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        pokeLabel.text = self.pokemon.name.capitalized
        pokeImage.image = UIImage (named: "\(self.pokemon.pokedexID)")
    }
    
}
