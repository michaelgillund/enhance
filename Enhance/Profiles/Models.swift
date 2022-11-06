//
//  Models.swift
//  Enhance
//
//  Created by Michael Gillund on 11/6/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import Foundation

struct Profile: Codable {
    var firstName = ""
    var lastName = ""
    var email = ""
    var telephone = ""
    
    var addressLine1 = ""
    var addressLine2 = ""
    var city = ""
    var state = ""
    var zipcode = ""
    var country = ""

    var cardName = ""
    var cardType = ""
    var card = ""
    var year = ""
    var month = ""
    var cvv = ""
}

struct Profiles: Codable {
    var profileList = [Profile]()
}
class Preferences {
    static let shared = Preferences()
    
    var profiles: Profiles? {
        get {
            guard let data = UserDefaults.standard.data(forKey: "PROFILE_DATA"),
                let profiles = try? JSONDecoder().decode(Profiles.self, from: data) else {
                    return nil
            }
            return profiles
            
        }
        set (newValue) {
            if let newValue = newValue {
                if let data = try? JSONEncoder().encode(newValue) {
                    UserDefaults.standard.set(data, forKey:"PROFILE_DATA")
                    return
                }
            }
            UserDefaults.standard.removeObject(forKey: "PROFILE_DATA")
        }
    }
}
