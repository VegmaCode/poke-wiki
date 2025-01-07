//
//  ApiNetwork.swift
//  Pokemon Wiki
//
//  Created by Víctor Estévez Gómez on 5/1/25.
//

import Foundation

class ApiNetwork{
    
    struct Wrapper:Codable{
        let id:Int
        let name:String
        let weight:Int
        let height:Int
        let sprites:Sprites
        let types:[Types]
        let moves:[Moves]
        let stats:[Stats]
    }
    
    struct Sprites:Codable{
        let front_default:String
    }
    
    struct Types:Codable{
        let type:Type2
    }
    
    struct Type2:Codable{
        let name:String
    }
    
    struct Moves:Codable{
        let move:Move
    }
    
    struct Move:Codable{
        let name:String
    }
    
    struct Stats:Codable{
        let base_stat:Int
        let stat:Stat
    }
    
    struct Stat:Codable{
        let name:String
    }
    
    func getPokeByName(name:String) async throws -> Wrapper{
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
        return wrapper
    }
    
}
