//
//  ContentView.swift
//  BookShelfSwiftUI
//
//  Created by OGUZHAN SARITAS.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ForEach(myFavourites){ favourite in
                        Section(header:Text(favourite.title)){
                            ForEach(favourite.elements){
                                element in
                                NavigationLink(destination: DetailView(choosenElement: element)){
                                    Text(element.name)
                                }
                                
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Favourites").font(.largeTitle))
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
