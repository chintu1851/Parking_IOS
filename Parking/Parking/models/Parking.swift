//
//  Parking.swift
//  ParkingFinalExam
//
//  Created by Anurag Negi on 2023-03-28.
//

import Foundation
import FirebaseFirestoreSwift

struct Parking : Codable, Hashable{
    @DocumentID var id : String? = UUID().uuidString
    var name : String = ""
    var hours : String = ""
    var license : String = ""
    var plate : String = ""
//    var location : [String:String] = [String:String]()
    var date : Date = Date()
    var address:String = ""
    
    init(){
        
    }
    
    init(name: String, hours : String, license : String, plate: String, date: Date,address:String){
        self.name = name
        self.hours = hours
        self.license = license
        self.plate = plate
//        self.location = location
        self.date = date
        self.address = address
    }
    
    init?(dictionary : [String : Any]){
        
        guard let name = dictionary["name"] as? String else{
            print(#function, "Unable to read name from the object")
            return nil
        }
        
        guard let hours = dictionary["hours"] as? String else{
            print(#function, "Unable to read hours from the object")
            return nil
        }
        
        guard let license = dictionary["license"] as? String else{
            print(#function, "Unable to read license from the object")
            return nil
        }
        
        guard let plate = dictionary["plate"] as? String else{
            print(#function, "Unable to read plate from the object")
            return nil
        }
        guard let address = dictionary["address"] as? String else{
            print(#function, "Unable to read plate from the object")
            return nil
        }
        
//        guard let location = dictionary["location"] as? [String:String] else{
//            print(#function, "Unable to read location from the object")
//            return nil
//        }
        
        guard let date = dictionary["date"] as? Date else{
            print(#function, "Unable to read date from the object")
            return nil
        }
        
        self.init(name: name, hours : hours, license : license, plate: plate, date: date,address:address)
        
    }
}
