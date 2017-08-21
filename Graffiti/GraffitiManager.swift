//
//  GraffitiManager.swift
//  Graffiti
//
//  Created by Rafael Navarro on 23/3/17.
//  Copyright © 2017 Rafael Navarro. All rights reserved.
//

import Foundation


class GraffitiManager{
    
    static let sharedInstance = GraffitiManager()
    
    var graffitis : [Graffiti] = [Graffiti]()
    
    func databaseURL() -> URL?{
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            let url = URL(fileURLWithPath: documentDirectory)
            return url.appendingPathComponent("graffity.data")
        } else {
            return nil
        }
        
    }
    
    func save() {
        if let url = databaseURL(){
            NSKeyedArchiver.archiveRootObject(graffitis, toFile: url.path)
        }else{
            print("error guardando datos")
        }
    }
    
    func load(){
        if let url = databaseURL(),
            let savedData = NSKeyedUnarchiver.unarchiveObject(withFile: url.path) as? [Graffiti]{
            graffitis = savedData
        }else{
            print("error cargando los datos")
        }
    }
    
    func imagesURL() -> URL?{
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            let url = URL(fileURLWithPath: documentDirectory)
            return url
        } else {
            return nil
        }
    }
    
}
