//
//  HeroView.swift
//  WidgetExample
//
//  Created by  OGUZHAN SARITAS.
//

import SwiftUI

struct HeroView: View {
    
    var hero:Superhero
    
    var body: some View {
       Spacer()
        HStack{
            
            CircularImageView(image: Image(hero.image)).frame(width: 150, height: 150, alignment: .center)
            Spacer()
            VStack{
                Text(hero.name).font(.largeTitle).fontWeight(.bold).foregroundColor(.blue)
                Text(hero.realName).fontWeight(.bold)
            }.padding()
            Spacer()
        }.frame(width: UIScreen.main.bounds.width, alignment: .center).padding()
    }
}

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        HeroView(hero: batman)
    }
}
