//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Eric Sirinian on 1/12/17.
//  Copyright © 2017 Eric Sirinian. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = pokemon.pokedexID
        
        let img = UIImage(named: "\(pokemon.pokedexID)")
        
        mainImg.image = img
        currentEvoImg.image = img
        
        pokemon.downloadPokemonDetail {
            //whatever written here will be called after downloadPokemonDetail
            self.updateUI()
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        self.typeLabel.text = pokemon.type
        self.heightLabel.text = pokemon.height
        self.weightLabel.text = pokemon.weight
        self.defenseLabel.text = pokemon.defense
        self.attackLabel.text = pokemon.attack
        self.descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvoID == "" {            
            self.evoLabel.text = "No Further Evolutions"
            nextEvoImg.isHidden = true
        } else {
            
            self.evoLabel.text = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLVL)"
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoID)
        }
    }
    

}
