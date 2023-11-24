//
//  ContentView.swift
//  Signin-Signup
//
//  Created by Patel Chintan on 2023-03-21.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct ContentView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @State private var useremail:String = ""
    @State private var password:String = ""
    @State private var createaccount:Int? = nil
    @State private var homeview:Int? = nil
    @State var errormessage = false
    @State var isAlert = false
    
    var body: some View {
        NavigationView{
            VStack {
                
                Text("Login")
                    .foregroundColor(.blue)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(10)
                TextField("Enter Your Email Address",text: $useremail)
                    .padding(15)
                    .foregroundColor(Color.blue)
                    .textInputAutocapitalization(.never)
                    .background(Color.gray.opacity(0.3))
                    .disableAutocorrection(true)
                    .font(.headline)
                    .cornerRadius(20)
                    .padding(10)
                
                SecureField("Enter Password",text: $password)
                    .padding(15)
                    .foregroundColor(Color.blue)
                    .textInputAutocapitalization(.never)
                    .background(Color.gray.opacity(0.3))
                    .disableAutocorrection(true)
                    .font(.headline)
                    .cornerRadius(20)
                    .padding(10)
                Spacer()
                NavigationLink(destination:Signup(),tag: 1, selection: $createaccount){}
                NavigationLink(destination:FirstScreen(),tag: 1, selection: $homeview){}
                Button(action:{
                    
                    if((self.useremail.isEmpty && self.password.isEmpty) || (self.useremail.isEmpty || self.password.isEmpty)){
                        
                        self.errormessage = true
                        self.isAlert = true
                    }
                    else if(self.password.count<8){
                        self.isAlert = true
                    }
                    else{
                        self.signIn(email: useremail, password: password)
                    useremail = ""
                    password = ""
                    }
                })
                {
                    Text("Login")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(15)
                        .frame(maxWidth: 120)
                }
                .alert(isPresented: $isAlert) {
                    Alert(
                        title: Text("Please check your personal information!")
                    )
                }
                .background(Color.blue)
                .cornerRadius(70)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color.blue,lineWidth: 0)
                        .foregroundColor(.black)
                )
                Button(action:{
                    self.createaccount = 1
                })
                {
                    Text("SignUp")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(15)
                        .frame(maxWidth: 120)
                }
                .background(Color.blue)
                .cornerRadius(70)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color.blue,lineWidth: 0)
                        .foregroundColor(.black)
                )
              
            }
           
        }
        .navigationBarBackButtonHidden(true)
    }
    
   private func signIn(email : String, password : String){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
          if let error = error {
            // An error occurred while signing in the user
            print("Error : \(error.localizedDescription)")
          } else {
            print("signed in!")
              self.homeview = 1

          }
        }
       UserDefaults.standard.set(email, forKey: "KEY_EMAIL")
       UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
