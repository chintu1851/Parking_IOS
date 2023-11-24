//
//  ParkingSlot.swift
//  Parking
//
//  Created by Harshil Vaghani on 2023-03-26.
//

import Foundation

struct Parkings : Codable{
    var carparks = [ParkingSlot]()
}

struct ParkingSlot : Codable{
    var id : String
    var address : String
    var lat : String
    var lng : String
    var rate : String
    var capacity : String
    
}
