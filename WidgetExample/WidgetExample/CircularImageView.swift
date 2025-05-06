//
//  CircularImageView.swift
//  WidgetExample
//
//  Created by OGUZHAN SARITAS.
//

import SwiftUI

struct CircularImageView: View {
    var image : Image
    var body: some View {
        image.resizable().aspectRatio(contentMode: .fit).clipShape(Circle()).overlay(Circle().stroke(Color.black,lineWidth: 5)).shadow(radius: 20)
    }
}

struct CircularImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularImageView(image:Image("batman"))
    }
}
