//
//  Graffiti.swift
//  Graffiti
//
//  Created by Rafael Navarro on 23/3/17.
//  Copyright © 2017 Rafael Navarro. All rights reserved.
//

import UIKit
import MapKit

class Graffiti: NSObject, NSCoding {
    
    let graffitiAdress : String
    let graffitiLatitude : Double
    let graffitiLongitude : Double
    let graffitiImageName : String
    
    init(address: String, latitude: Double, longitude: Double, image: String) {
        self.graffitiAdress = address
        self.graffitiLatitude = latitude
        self.graffitiLongitude = longitude
        self.graffitiImageName = image
        
    }

    //MARK: NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        let graffitiAdrress = aDecoder.decodeObject(forKey: "graffitiAddress") as! String
        let graffitiLatitude = aDecoder.decodeDouble(forKey: "graffitiLatitude")
        let graffitiLongitude = aDecoder.decodeDouble(forKey: "graffitiLongitude")
        let graffitiImageName = aDecoder.decodeObject(forKey: "graffitiImageName") as! String
        self.init(address: graffitiAdrress, latitude: graffitiLatitude, longitude: graffitiLongitude, image: graffitiImageName)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.graffitiAdress, forKey: "graffitiAddress")
        aCoder.encode(self.graffitiLatitude, forKey: "graffitiLatitude")
        aCoder.encode(self.graffitiLongitude, forKey: "graffitiLongitude")
        aCoder.encode(self.graffitiImageName, forKey: "graffitiImageName")
    }
}

extension Graffiti: MKAnnotation{
    var coordinate: CLLocationCoordinate2D{
        get{
            return CLLocationCoordinate2D(latitude: graffitiLatitude, longitude: graffitiLongitude)
        }
    }
    
    var title: String?{
        get{
            return "Graffiti"
        }
    }
    
    var subtitle: String?{
        get{
            return graffitiAdress.replacingOccurrences(of: "\n", with: "")
        }
    }
}
