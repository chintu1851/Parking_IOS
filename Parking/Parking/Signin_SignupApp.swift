//
//  Signin_SignupApp.swift
//  Signin-Signup
//
//  Created by Patel Chintan on 2023-03-21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
@main
struct Signin_SignupApp: App {
    var fireAuthHelper = FireAuthHelper()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(fireAuthHelper)
        }
    }
}
