//
//  FirstScreen.swift
//  Parking
//
//  Created by Harshil Vaghani on 2023-03-26.
//

import SwiftUI

struct FirstScreen: View {
    @State private var selection : Int? = nil
    @State private var signout : Int? = nil

    var body: some View {
      NavigationView(){
      
            TabView{
                Home().tabItem{
                    Image(systemName: "list.bullet")
                }
                MapView().tabItem{
                    Image(systemName: "location")
                }
            }
      }
      .navigationBarBackButtonHidden()
    }
}

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
