//
//  ContentView.swift
//  WidgetExample
//
//  Created by OGUZHAN SARITAS.
//

import SwiftUI
import WidgetKit
let superHeroArray = [batman,deadpool,hulk]


struct ContentView: View {
    
    @AppStorage("hero",store:UserDefaults(suiteName: "//bundleID"))
    var heroData : Data = Data()
    var body: some View {
        VStack {
            ForEach(superHeroArray){ hero in
                HeroView(hero:hero).onTapGesture {
                    saveToDefaults(hero: hero)
                }
                
            }
        }
    }
    
    func saveToDefaults(hero:Superhero){
        if let heroData = try? JSONEncoder().encode(hero){
            self.heroData = heroData
            print(hero.name)
            WidgetCenter.shared.reloadTimelines(ofKind: "HeroWidget")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
