//
//  FireDBHelper.swift
//  ParkingFinalExam
//
//  Created by Anurag Negi on 2023-03-28.
//

import Foundation
import FirebaseFirestore


class FireDBHelper : ObservableObject{
    
    @Published var parkingList = [Parking]()
    
    @Published var infoList = [String:String]()
    private let store : Firestore
    private static var shared : FireDBHelper?
    private let COLLECTION_PARKING : String = "Parking"
    private let COLLECTION_CARS : String = "Users"
    
    private let FIELD_HOURS : String = "hours"
    private let FIELD_LICENSE : String = "license"
    private let FIELD_PLATE : String = "plate"
    private let FIELD_DATE : String = "date"
    private let FIELD_NAME : String = "name"
    
    var loggedInUserEmail : String = ""
    
    init(store: Firestore) {
        self.store = store
    }
    
    static func getInstance() -> FireDBHelper?{
        if (shared == nil){
            shared = FireDBHelper(store: Firestore.firestore())
        }
        
        return shared
    }
    
    func insertParking(newParking : Parking){
        print(#function, "Trying to insert parking \(newParking.license) to firestore")
        
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }else{
            
            do{
                try self.store
                    .collection(COLLECTION_CARS)
                    .document(loggedInUserEmail)
                    .collection(COLLECTION_PARKING)
                    .addDocument(from: newParking)
            }catch let error as NSError{
                print(#function, "Unable to add document to firestore : \(error)")
            }
        }
    }
    
    func getAllParking(){

        self.parkingList=[]
        
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""

        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }else{
            self.store
                .collection(COLLECTION_CARS)
                .document(loggedInUserEmail)
                .collection(COLLECTION_PARKING)
                .addSnapshotListener({ (querySnapshot, error) in

                    guard let snapshot = querySnapshot else{
                        print(#function, "Unable to retrieve data from Firestore : \(error)")
                        return
                    }

                    snapshot.documentChanges.forEach{ (docChange) in

                        do{
                            var parking : Parking = try docChange.document.data(as: Parking.self)

                            let docID = docChange.document.documentID
                            parking.id = docID

                            let matchedIndex = self.parkingList.firstIndex(where: { ($0.id?.elementsEqual(docID))! })

                            if docChange.type == .added{
                                self.parkingList.append(parking)
                                print(#function, "Document added : \(parking)")
                            }

                            if docChange.type == .removed{
                                if (matchedIndex != nil){
                                    self.parkingList.remove(at: matchedIndex!)
                                }
                            }

                            if docChange.type == .modified{
                                if (matchedIndex != nil){
                                    self.parkingList[matchedIndex!] = parking
                                }
                            }

                        }catch let err as Error{
                            print(#function, "Unable to convert the document into object : \(err)")
                        }
                    }

                })
        }
    }
    
    func deleteParking(parkingToDelete : Parking){
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""

        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }else{
            self.store
                .collection(COLLECTION_CARS)
                .document(loggedInUserEmail)
                .collection(COLLECTION_PARKING)
                .document(parkingToDelete.id!)
                .delete{error in

                    if let error = error {
                        print(#function, "Unable to delete document : \(error)")
                    }else{
                        print(#function, "Successfully deleted \(parkingToDelete.license) parking from the firestore")
                    }

                }
        }
    }
    

    
}
