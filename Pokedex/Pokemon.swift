//
//  Pokemon.swift
//  Pokedex
//
//  Created by Eric Sirinian on 1/11/17.
//  Copyright © 2017 Eric Sirinian. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: String!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoTxt: String!
    private var _nextEvoName: String!
    private var _nextEvoID: String!
    private var _nextEvoLVL: String!
    
    private var _pokemonURL: String!
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var pokedexID: String {
        if _pokedexID == nil {
            _pokedexID = ""
        }
        return _pokedexID
    }
    
    var description: String {
        if _description == nil {
            _description = "hello"
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvoTxt: String {
        if _nextEvoTxt == nil {
            _nextEvoTxt = ""
        }
        return _nextEvoTxt
    }
    
    var nextEvoName: String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoID: String {
        if _nextEvoID == nil {
            _nextEvoID = ""
        }
        return _nextEvoID
    }
    
    var nextEvoLVL: String {
        if _nextEvoLVL == nil {
            _nextEvoLVL = ""
        }
        return _nextEvoLVL
    }
    
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = "\(pokedexID)"
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._name = name.capitalized
                }
                
                if let pokedexID = dict["pkdx_id"] as? Int {
                    self._pokedexID = "\(pokedexID)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, AnyObject>] , types.count > 0 {
                    
                    if let type = types[0]["name"] as? String {
                        self._type = type.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            if let type = types[x]["name"] {
                                self._type! += "/\(type.capitalized!)"
                            }
                        }
                    }
                    
                } else {
                    self._type = ""
                }
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Double {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Double {
                    self._defense = "\(defense)"
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>], evolutions.count > 0 {
                    
                    if let evoTo = evolutions[0]["to"] as? String {
                        
                        if evoTo.range(of: "mega") == nil {
                            self._nextEvoName = evoTo
                            
                            if let url = evolutions[0]["resource_uri"] as? String {
                                
                                let str = url.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoID = str.replacingOccurrences(of: "/", with: "")
                                self._nextEvoID = nextEvoID
                                
                                if let lvlExit = evolutions[0]["level"] {
                                    
                                    if let lvlTo = lvlExit as? Int {
                                        self._nextEvoLVL = "\(lvlTo)"
                                    }
                                    
                                } else {
                                    self._nextEvoLVL = ""
                                }
                                
                            }
                            
                        }
                    }
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, AnyObject>], descriptions.count > 0 {
                    
                    if var url = descriptions[descriptions.count-1]["resource_uri"] as? String {
                        
                        url.remove(at: url.startIndex)
                        
                        let descriptionURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descriptionURL).responseJSON { response in
                            
                            let descResult = response.result
                            
                            if let descDict = descResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    var tempStr = description
                                    
                                    tempStr = tempStr.replacingOccurrences(of: "\n", with: " ")
                                    
                                    self._description = tempStr
                                    
                                }
                                
                            }
                            completed()
                        }

                    }
                } else {
                    
                    self._description = ""
                }
            }
            completed()
        }
    }
}








