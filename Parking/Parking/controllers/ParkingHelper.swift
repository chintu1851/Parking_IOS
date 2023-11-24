//
//  ParkingHelper.swift
//  Parking
//
//  Created by Harshil Vaghani on 2023-03-26.
//

import Foundation
import MapKit

class ParkingHelper : ObservableObject{
    @Published var slots = [ParkingSlot]()
    @Published var locationList = [SlotLocation]()
    
    private let baseURL = "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/b66466c3-69c8-4825-9c8b-04b270069193/resource/8549d588-30b0-482e-b872-b21beefdda22/download/green-p-parking-2019.json"
    
    func fetchParkingSlots(){
        guard let api = URL(string: baseURL) else{
            print(#function, "Unable to convert string to URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: api){ (data : Data?, response : URLResponse?, error : Error?) in
            
            if let error = error{
                print(#function, "Error while connecting to network \(error)")
            }
            else{
                if let httpResponse = response as? HTTPURLResponse{
                    if (httpResponse.statusCode == 200){
                        DispatchQueue.global().async {
                            do{
                                if (data != nil){
                                    if let jsonData = data{
                                        let jsonDecoder = JSONDecoder()
                                        var parkings = try jsonDecoder.decode(Parkings.self, from: jsonData)
                                        
                                        DispatchQueue.main.async {
                                            self.slots = parkings.carparks
                                            for i in self.slots{
                                                self.locationList.append(SlotLocation(id: i.id,address: i.address, coordinate: CLLocationCoordinate2D(latitude: Double(i.lat) ?? 0.0, longitude: Double(i.lng) ?? 0.0)))
                                            }
                                        }
                                    }
                                    else{
                                        print(#function, "Unable to get the JSON data")
                                    }
                                }
                                else{
                                    print(#function, "Response received without data")
                                }
                            }
                            catch let error{
                                print(#function, "Error while extracting data : \(error)")
                            }
                        }
                    }
                    else{
                        print(#function, "Unsuccessful response. Response Code : \(httpResponse.statusCode)")
                    }
                }
                else{
                    print(#function, "Unable to get HTTP Response")
                }
            }
        }
        task.resume()
    }
}
