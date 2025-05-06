//
//  DetailView.swift
//  BookShelfSwiftUI
//
//  Created by OGUZHAN SARITAS.
//

import SwiftUI

struct DetailView: View {
    
    var choosenElement:FavouriteElements
    var body: some View {
        VStack{
            Image(choosenElement.imagename).resizable().aspectRatio(contentMode: .fit).padding()
            Text(choosenElement.name).padding()
            Text(choosenElement.description).padding()
            
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(choosenElement: whiplash)
    }
}
