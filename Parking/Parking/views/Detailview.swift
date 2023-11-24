//
//  Detailview.swift
//  Parking
//
//  Created by Patel Chintan on 2023-03-29.
//

import SwiftUI

struct Detailview: View {
    var selectedplace:ParkingSlot
    @State private var slots = ""
    //let selectedindex:Int
    @State private var showErrorAlert : Bool = false
    @State private var carerror : Bool = false
    @State private var success : Bool = false
    @State private var alertMessage : String = ""
    @State private var result : String = ""
    let pattern = "^[a-zA-Z][0-9]{13}$"
    let pattern2 = "^[A-Za-z]{4}\\d{3}$"
    @State private var errorMessage = ""
    @State private var signout : Int? = nil
    let times = ["30 Minutes","1 Hour","3 Hours","12 Hours", "Whole-Day"]
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @State private var name : String = ""
    @State private var hours : String = "30 Minutes"
    @State private var license : String = ""
    @State private var plate : String = ""
    @State private var address : String = ""
    @State private var selection : Int? = nil
    @State private var date : Date = Date()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    
    var body: some View {
        
        VStack(){
            Text("Park-IN: TORONTO ")
                .foregroundColor(.blue)
                .font(.title)
                .fontWeight(.bold)
                .padding(5)
            Text("Address: \(selectedplace.address)")
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            Text("Rate: \(selectedplace.rate)")
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Form{
                
                TextField("Enter Legal Name", text: self.$name)
                    .disableAutocorrection(true)
                    .autocapitalization(.words)
                
                TextField("Enter Driving License Number in ^[a-zA-Z][0-9]{13}$ Format", text: self.$license)
                    .disableAutocorrection(true)
                
                TextField("Enter Car Plate No.in the ^[A-Za-z]{4}\\d{3}$ Format", text: self.$plate)
                    .disableAutocorrection(true)
                
                
                Section(header: Text("Date & Time")) {
                    DatePicker("", selection: $date)
                    Picker("Booking Length", selection: $hours) {
                        ForEach(times, id: \.self) {
                            Text($0)
                        }
                    }
                }
                .padding(.horizontal, 16)
                
                Button(action: {
                    self.addNewParking()
                    
                })
                {
                    
                    HStack {
                        Image(systemName: "plus")
                            .font(.subheadline)
                        Text("Add Details")
                            .fontWeight(.semibold)
                            .font(.subheadline)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(20)
                }
                .frame(maxWidth: .infinity)
                .alert(isPresented: self.$showErrorAlert){
                    
                    if carerror{
                        return  Alert(
                            title: Text("Error"),
                            message: Text(self.alertMessage),
                            dismissButton: .default(Text("Try Again"))
                        )
                    }
                    return Alert(
                        title: Text("Car Added Successfully!")
                    )
                }
                
                //.navigationViewStyle(StackNavigationViewStyle())
                
            }//Form inside VStack ends
            
        }//VStack ends
    }
    
    private func addNewParking(){
        
        if (self.name.isEmpty || self.plate.isEmpty || self.license.isEmpty){
            //show error
            
            self.showErrorAlert = true
            self.carerror = true
            self.alertMessage = "Fields cannot be empty"
        }
        else if (self.name.count == 1 ){
            self.showErrorAlert = true
            self.carerror = true
            self.alertMessage = "Name Must be more than one character"
            
        }
        else if ((self.license.range(of: pattern, options:.regularExpression))==nil){
            self.showErrorAlert = true
            self.carerror = true
            self.alertMessage = "License plate number must be of correct format!"
            // self.showErrorAlert = true
        }
        else if ((self.plate.range(of: pattern2, options:.regularExpression))==nil){
            self.showErrorAlert = true
            self.carerror = true
            self.alertMessage = "Plate no. must be correct format"
            //self.showErrorAlert = true
        }
        
        else{
            
            let newParking = Parking(name: self.name, hours : self.hours, license : self.license, plate: self.plate, date: self.date, address: self.selectedplace.address)
            self.showErrorAlert = true
            self.fireDBHelper.insertParking(newParking: newParking)
            dismiss()
        }
    }
    
    
}
