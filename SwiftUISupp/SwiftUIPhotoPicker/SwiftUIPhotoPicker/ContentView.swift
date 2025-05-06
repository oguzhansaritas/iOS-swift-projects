//
//  ContentView.swift
//  SwiftUIPhotoPicker
//
//  Created by OGUZHAN SARITAS.
//

import SwiftUI
import PhotosUI
struct ContentView: View {
    
    @State var selectedItem :[PhotosPickerItem]=[]
    @State var data : Data?
    var body: some View {
        VStack {
            if let data = data{
                if let selectedImage = UIImage(data: data){
                    Image(uiImage: selectedImage).resizable().frame(width:300,height:200,alignment: .center)
                }
            }
            
            
            PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, selectionBehavior: .default, matching: .images, preferredItemEncoding: .automatic) {
                Text("Select An Image")
            }.onChange(of: selectedItem) { newValue in
                guard let item = selectedItem.first else{
                    return
                }
                item.loadTransferable(type: Data.self) { result in
                    switch result{
                    case .success(let data):
                        if let data = data{
                            self.data = data
                        }
                    case.failure(let error):
                        print(error)
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
