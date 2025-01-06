//
//  ContentView.swift
//  Pokemon Wiki
//
//  Created by Víctor Estévez Gómez on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    //let defaultURL:String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/25.png"
    @State var wrapper:ApiNetwork.Wrapper? = nil
    @State var defaultWrapper:ApiNetwork.Wrapper = ApiNetwork.Wrapper(id: 0, name: "Sin nombre", weight: 0, sprites: ApiNetwork.Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png"), types: [ApiNetwork.Types(type: ApiNetwork.Type2(name: ""))],
                                                                      moves: [],
                                                                      stats: [ApiNetwork.Stats(base_stat: 0, stat: ApiNetwork.Stat(name: "")), ApiNetwork.Stats(base_stat: 0, stat: ApiNetwork.Stat(name: "")), ApiNetwork.Stats(base_stat: 0, stat: ApiNetwork.Stat(name: "")), ApiNetwork.Stats(base_stat: 0, stat: ApiNetwork.Stat(name: "")), ApiNetwork.Stats(base_stat: 0, stat: ApiNetwork.Stat(name: ""))])
    @State var pokeName:String = ""
    
    var body: some View {
        ZStack {
            Image("background").resizable().frame(width: 480, height: 920).scaledToFill().blur(radius: 2)
            
            VStack{
                TextField("Buscar Pokémon", text: $pokeName)
                    .frame(width: 300, height: 60)
                    .padding(.horizontal)
                    .autocorrectionDisabled()
                    .background(Color("component").opacity(0.8))
                    .cornerRadius(10)
                    .onSubmit {
                        Task{
                            do{
                                wrapper = try await ApiNetwork().getPokeByName(name: pokeName.lowercased())
                                print(wrapper!.sprites.front_default)
                            }catch{
                                print("ERROR")
                            }
                        }
                    }
                CreateResultView(mywrap: wrapper ?? defaultWrapper)
            }
        }
    }
}

struct CreateResultView:View{
    let mywrap:ApiNetwork.Wrapper
    @State var batteryLevel = 0.4
    var body: some View{
        
        VStack {
            Text(mywrap.name.capitalized).font(.largeTitle).bold()
            HStack{
                VStack{
                    Text("Nombre: ").bold() + Text(mywrap.name.capitalized)
                    Text("Nº Pokédex: ").bold() + Text("\(mywrap.id)")
                    Text("Peso: ").bold() + Text("\(mywrap.weight)Kg")
                    HStack{
                        Text("Tipo: ").bold()
                        ForEach(mywrap.types, id: \.type.name) { type in
                            Text(typeTranslator(value: type.type.name))
                        }
                    }
                    HStack{
                        
                    }
                   
                }
                AsyncImage(url: URL(string: mywrap.sprites.front_default))
                    .frame(width: 120, height: 120)
            }
            Text("Movimientos: ").bold()
            List(mywrap.moves, id: \.move.name){ move in
                Text(move.move.name.capitalized).listRowSeparator(.hidden).listRowBackground(Color("component").opacity(0.5)).cornerRadius(10)
            }.frame(maxWidth: 320, maxHeight: 200).listStyle(.plain).cornerRadius(10)
            /*ForEach(mywrap.stats, id: \.stat.name){ stat in
                Text(stat.stat.name).bold() + Text(String(stat.base_stat))
            }*/
            HStack{
                Image(systemName: "heart.fill")
                Text("Salud").font(.footnote)
                Spacer()
                Gauge(value: mapToRange(value: Double(mywrap.stats[0].base_stat), inputMin: 0.0, inputMax: 150.0, outputMin: 0.0, outputMax: 1.0)) {}.frame(minWidth: 200, maxWidth: 200, minHeight: 10, maxHeight: 10).tint(.red)
            }
            HStack{
                Image(systemName: "bolt.fill")
                Text("Ataque").font(.footnote)
                Spacer()
                Gauge(value: mapToRange(value: Double(mywrap.stats[1].base_stat), inputMin: 0.0, inputMax: 150.0, outputMin: 0.0, outputMax: 1.0)) {}.frame(minWidth: 200, maxWidth: 200, minHeight: 10, maxHeight: 10).tint(.orange)
            }
            HStack{
                Image(systemName: "shield.fill")
                Text("Defensa").font(.footnote)
                Spacer()
                Gauge(value: mapToRange(value: Double(mywrap.stats[2].base_stat), inputMin: 0.0, inputMax: 150.0, outputMin: 0.0, outputMax: 1.0)) {}.frame(minWidth: 200, maxWidth: 200, minHeight: 10, maxHeight: 10).tint(.blue)
            }
            HStack{
                Image(systemName: "sparkles")
                Text("Ataque X").font(.footnote)
                Spacer()
                Gauge(value: mapToRange(value: Double(mywrap.stats[3].base_stat), inputMin: 0.0, inputMax: 150.0, outputMin: 0.0, outputMax: 1.0)) {}.frame(minWidth: 200, maxWidth: 200, minHeight: 10, maxHeight: 10).tint(.purple)
            }
            HStack{
                Image(systemName: "bolt.shield.fill")
                Text("Defensa X").font(.footnote)
                Spacer()
                Gauge(value: mapToRange(value: Double(mywrap.stats[4].base_stat), inputMin: 0.0, inputMax: 150.0, outputMin: 0.0, outputMax: 1.0)) {}.frame(minWidth: 200, maxWidth: 200, minHeight: 10, maxHeight: 10).tint(.green)
            }.padding(.bottom)
            
        }.padding(.horizontal)
            .frame(maxWidth: 350)
            .frame(height: 520)
            .background(Color("component").opacity(0.5))
            .cornerRadius(16)
    }
}

func tryToPrint(value:String){
    print(value)
}

func mapToRange(value: Double, inputMin: Double, inputMax: Double, outputMin: Double, outputMax: Double) -> Double {
    return outputMin + (value - inputMin) / (inputMax - inputMin) * (outputMax - outputMin)
}

func typeTranslator(value:String) -> String{
    
    switch value{
    case "normal":
        return "Normal"
    case "fire":
        return "Fuego"
    case "water":
        return "Agua"
    case "electric":
        return "Eléctrico"
    case "grass":
        return "Planta"
    case "ice":
        return "Hielo"
    case "fighting":
        return "Lucha"
    case "poison":
        return "Veneno"
    case "ground":
        return "Tierra"
    case "flying":
        return "Volador"
    case "psychic":
        return "Psíquico"
    case "bug":
        return "Bicho"
    case "rock":
        return "Roca"
    case "ghost":
        return "Fantasma"
    case "dragon":
        return "Dragón"
    case "dark":
        return "Siniestro"
    case "steel":
        return "Acero"
    case "fairy":
        return "Hada"
    default:
        return "Sin tipo"
    }
}
#Preview {
    ContentView()
}
