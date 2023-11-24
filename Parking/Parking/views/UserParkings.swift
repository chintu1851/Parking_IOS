//
//  UserParkings.swift
//  Parking
//
//  Created by Anurag Negi on 2023-03-29.
//
import SwiftUI

struct UserParkings: View {
    @State private var showNewParkingView : Bool = false
    @State private var selection : Int? = nil
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @State private var signout : Int? = nil

    var body: some View {
        ZStack(alignment: .bottom){
            List{
                ForEach(self.fireDBHelper.parkingList.enumerated().map({$0}), id: \.element.self){index, currentParking in
                    VStack(alignment: .leading){
                        Text("Driver License: \(currentParking.license)")
                            .font(.system(size: 20))
                            .bold()
                        HStack{
                            Text("Address:")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                            Text(currentParking.address)
                        }
                        HStack {
                            Text("License Plate:")
                                .fontWeight(.semibold)
                                .font(.system(size: 15))
                            Text(currentParking.plate)
                        }
                        HStack{
                            Text("Date:\(currentParking.date)")

                            Text("")
                        }
                       
                    }
                }
                .onDelete(perform: {indexSet in
                    for index in indexSet{
                        
                        self.fireDBHelper.deleteParking(parkingToDelete: self.fireDBHelper.parkingList[index])
                    }
                })
                
            }
            NavigationLink(destination: ContentView().environmentObject(fireAuthHelper), tag: 1, selection: self.$signout){}
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Menu{
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
            .navigationTitle("My Bookings")
            .onAppear(){
                self.fireDBHelper.getAllParking()
            }
        }
        
    }
}
