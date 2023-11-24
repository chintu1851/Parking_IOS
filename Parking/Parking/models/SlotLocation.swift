//
//  SlotLocation.swift
//  Parking
//
//  Created by Harshil Vaghani on 2023-03-26.
//

import Foundation
import MapKit

struct SlotLocation: Identifiable {
    let id : String
    let address:String
    let coordinate: CLLocationCoordinate2D
}
