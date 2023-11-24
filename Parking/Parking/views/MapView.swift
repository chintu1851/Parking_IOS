import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.6532, longitude: -79.38), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
    @State private var userTrackingMode = MapUserTrackingMode.follow
    @EnvironmentObject var parkingHelper : ParkingHelper
    
    var body: some View {
        VStack{
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: self.parkingHelper.locationList) {location in
                MapPin(coordinate: location.coordinate)
                
            }
            .frame()
        }
        .onAppear(){
            self.parkingHelper.fetchParkingSlots()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
