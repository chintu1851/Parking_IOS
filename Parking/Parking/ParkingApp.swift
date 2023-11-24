//
//  ParkingApp.swift
//  Parking
//
//  Created by Harshil Vaghani on 2023-03-26.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@main
struct ParkingApp: App {
    
    var parkingHelper = ParkingHelper()
    var fireauth = FireAuthHelper()
    var firedbhelper:FireDBHelper
    init(){
        FirebaseApp.configure()
        firedbhelper = FireDBHelper.getInstance() ?? FireDBHelper(store: Firestore.firestore())
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(parkingHelper).environmentObject(fireauth).environmentObject(firedbhelper)
        }
    }
}
