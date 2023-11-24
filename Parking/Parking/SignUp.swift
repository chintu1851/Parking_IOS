//
//  SignUp.swift
//  Signin-Signup
//
//  Created by Patel Chintan on 2023-03-21.
//

import SwiftUI

struct SignUp: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @State private var useremail:String = ""
    @State private var password:String = ""
    @State private var confirmpassword:String = ""
    @State private var loginview:Int? = nil
    @State var isAlert = false
    @State var ischeck = false
    var body: some View {
        VStack {
            
            Text("Create Account")
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
            SecureField("Confirm Password",text: $confirmpassword)
                .padding(15)
                .foregroundColor(Color.blue)
                .textInputAutocapitalization(.never)
                .background(Color.gray.opacity(0.3))
                .disableAutocorrection(true)
                .font(.headline)
                .cornerRadius(20)
                .padding(10)
            NavigationLink(destination:ContentView(),tag: 1, selection: $loginview){}
            Spacer()
            Button(action:{
                
                if((self.useremail.isEmpty && self.password.isEmpty) || (self.useremail.isEmpty || self.password.isEmpty)){
                    
                    //self.errormessage = true
                    self.isAlert = true
                    self.ischeck = true
                }
                else if(self.password.count<8){
                    self.isAlert = true
                    self.ischeck = true
                }
                else if(self.password != self.confirmpassword){
                    self.isAlert = true
                    self.ischeck = true
                }
                else{
                    self.fireAuthHelper.signUp(email: useremail, password: password)
                    isAlert = true
                    self.ischeck = false
                    useremail = ""
                    password = ""
                    confirmpassword = ""
                }
               
            })
            {
                Text("SignUp")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(15)
                    .frame(maxWidth: 120)
            }
            
            .alert(isPresented: $isAlert) {
                if ischeck{
                    return Alert(
                    title: Text("Please check your personal information!")
                )
                }
                return Alert(
                        title: Text("Account Created Successfully!")
                     
                    )
                
            }
            .background(Color.blue)
            .cornerRadius(70)
            .overlay(
                RoundedRectangle(cornerRadius: 60)
                    .stroke(Color.blue,lineWidth: 0)
                    .foregroundColor(.black)
            )
           
        }
        .padding()
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
