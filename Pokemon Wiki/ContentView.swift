//
//  ContentView.swift
//  Pokemon Wiki
//
//  Created by Víctor Estévez Gómez on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    @State var pokeName:String = ""
    @State var wrapper:ApiNetwork.Wrapper? = nil
    @State var defaultWrapper:ApiNetwork.Wrapper = ApiNetwork.Wrapper(id: 0, name: "", weight: 0, height: 0 ,
                                                                      sprites: ApiNetwork.Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png"),
                                                                      types: [ApiNetwork.Types(type: ApiNetwork.Type2(name: ""))],
                                                                      moves: [],
                                                                      stats: [ApiNetwork.Stats(base_stat: 0, stat: ApiNetwork.Stat(name: "")), ApiNetwork.Stats(base_stat: 0, stat: ApiNetwork.Stat(name: "")), ApiNetwork.Stats(base_stat: 0, stat: ApiNetwork.Stat(name: "")), ApiNetwork.Stats(base_stat: 0, stat: ApiNetwork.Stat(name: "")), ApiNetwork.Stats(base_stat: 0, stat: ApiNetwork.Stat(name: ""))])
    
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

                            }catch{
                                print("Error al obtener datos desde la API")
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
            Text(mywrap.name.capitalized).font(.largeTitle).bold().padding(.top)
            HStack{
                VStack{
                    HStack{
                        Text("Tipo: ").bold()
                        ForEach(mywrap.types, id: \.type.name) { type in
                            Text(typeTranslator(value: type.type.name))
                        }
                    }
                    Text("Nº Pokédex: ").bold() + Text("\(mywrap.id)")
                    Text("Peso: ").bold() + Text("\(mywrap.weight)Kg")
                    Text("Altura: ").bold() + Text(String(format: "%.2f", Float(mywrap.height) / 10) + "m")
                }
                Spacer()
                AsyncImage(url: URL(string: mywrap.sprites.front_default))
                    .frame(width: 120, height: 120)
            }
            Text("Movimientos: ").bold()
            List(mywrap.moves, id: \.move.name){ move in
                Text(move.move.name.capitalized).listRowSeparator(.hidden).listRowBackground(Color("component").opacity(0.5)).cornerRadius(10)
            }.frame(maxWidth: 320, maxHeight: 200).listStyle(.plain).cornerRadius(10).padding(.bottom)

            // Medidores de estadísiticas
            gaugeStatView(systemImage: "heart.fill", text: "Salud", stat: 0, wrap: mywrap, color: "stat_red") //Salud
            gaugeStatView(systemImage: "bolt.fill", text: "Ataque", stat: 1, wrap: mywrap, color: "stat_orange") //Ataque
            gaugeStatView(systemImage: "shield.fill", text: "Defensa", stat: 2, wrap: mywrap, color: "stat_blue") //Defensa
            gaugeStatView(systemImage: "sparkles", text: "Ataque X", stat: 3, wrap: mywrap, color: "stat_purple") //Ataque X
            gaugeStatView(systemImage: "bolt.shield.fill", text: "Defensa X", stat: 4, wrap: mywrap, color: "stat_green").padding(.bottom) //Defensa X
            
        }.padding(.horizontal)
            .frame(maxWidth: 350)
            .frame(height: 550)
            .background(Color("component").opacity(0.5))
            .cornerRadius(16)
    }
}

struct gaugeStatView:View {
    let systemImage:String
    let text:String
    let stat:Int
    let wrap:ApiNetwork.Wrapper
    let color:String
    var body: some View {
        HStack{
            Image(systemName: systemImage)
            Text(text).font(.footnote)
            Spacer()
            Gauge(value: mapToRange(value: Double(wrap.stats[stat].base_stat), inputMin: 0.0, inputMax: 150.0, outputMin: 0.0, outputMax: 1.0)) {}.frame(minWidth: 200, maxWidth: 200, minHeight: 10, maxHeight: 10).tint(Color(color))
        }
    }
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
        return "-"
    }
}
#Preview {
    ContentView()
}
