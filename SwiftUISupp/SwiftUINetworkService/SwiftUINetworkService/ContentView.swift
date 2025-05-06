//
//  ContentView.swift
//  SwiftUINetworkService
//
//  Created by OGUZHAN SARITAS.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userListViewModel : UserListViewModel
    init(){
        self.userListViewModel = UserListViewModel(service:LocalService())
        // LocalService() or WebService()
    }
    var body: some View {
        List(userListViewModel.userList,id: \.id){user in
            VStack{
                Text(user.name).font(.title3).foregroundColor(.blue).frame(maxWidth:.infinity,alignment: .leading)
                Text(user.username).font(.title3).foregroundColor(.gray).frame(maxWidth:.infinity,alignment: .leading)
                Text(user.email).font(.title3).foregroundColor(.black).frame(maxWidth:.infinity,alignment: .leading)
            }
        }.task{
            await userListViewModel.downloadUsers()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
