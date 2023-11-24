//
//  ContentView.swift
//  Parking
//
//  Created by Harshil Vaghani on 2023-03-26.
//

import SwiftUI
import MapKit

struct Home: View {
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var parkingHelper : ParkingHelper
    @State private var selection : Int? = nil
    @State private var signout : Int? = nil
    @State private var searchlocation = ""
    
    var body: some View {
       // NavigationView(){
            VStack{
                NavigationLink(destination: ContentView().environmentObject(fireAuthHelper), tag: 1, selection: self.$signout){}
                NavigationLink(destination: UserParkings().environmentObject(fireDBHelper).environmentObject(fireAuthHelper), tag: 3, selection: self.$selection){}
                List{
                    ForEach(searchlist, id: \.self) {currentSlot in
                        NavigationLink(destination: Detailview(selectedplace: self.parkingHelper.slots[currentSlot])){
                            VStack(alignment:.leading){
                                Text(self.parkingHelper.slots[currentSlot].address)
                                    .fontWeight(.semibold)
                                Text(self.parkingHelper.slots[currentSlot].rate)
                                Text("Capacity: \(self.parkingHelper.slots[currentSlot].capacity)")
                                
                            }
                        }
                    }
                }
                .searchable(text: $searchlocation).autocorrectionDisabled()
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing){
                            Menu{
                                
                                
                                Button(action: {
                                    self.selection=3
                                }){
                                    Label("My Parkings", systemImage: "doc")
                                }
                                Button(action: {
                                    self.signout = 1
                                    self.fireAuthHelper.signOut()
                                    
                                }){
                                    Label("Sign Out", systemImage: "figure.wave")
                                }
                            }
                        label:{
                            Label("Add",systemImage: "ellipsis.rectangle.fill")
                                .padding(10)
                        }
                        }
                    }
            }.onAppear(){
                print("cintan")
                self.parkingHelper.fetchParkingSlots()
               
            }
       // }
//        .navigationViewStyle(StackNavigationViewStyle())
    }
        var searchlist: [Int] {
            if searchlocation.isEmpty {
                return Array(0..<self.parkingHelper.slots.count)
            } else {
                return self.parkingHelper.slots.indices.filter { index in
                    let slot = self.parkingHelper.slots[index]
                    return slot.address.localizedCaseInsensitiveContains(searchlocation)
                }
            }
        }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
