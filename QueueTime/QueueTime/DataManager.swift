//
//  DataManager.swift
//  
//
//  Created by Ivo van der Zee on 02/12/2018.
//

import Foundation
import Intents


class DataManager {
    
    static let sharedManager = DataManager()
    static let sharedSuiteName = "group.com.ivovanderzee.QueueTime"
    
    let userDefaults  = UserDefaults(suiteName: sharedSuiteName)
    
    func findContact(contactName: String?, with completion: ([INPerson]) -> Void) {
        
        let savedContacts = userDefaults?.value(forKey: DataManager.sharedSuiteName) as? [[String: String]]
        
        var matchingContacts = [INPerson]()
        
        if let contacts = savedContacts {
            
            for contact in contacts {
                
                if let name = contact["name"]?.lowercased(), name.contains(contactName!.lowercased()) {
                    
                    let personHandle  = INPersonHandle(value: contact["number"], type: .phoneNumber)
                    matchingContacts.append(INPerson(personHandle: personHandle, nameComponents: nil, displayName: name, image: nil, contactIdentifier: nil, customIdentifier: personHandle.value))
                }
            }
        }
        
        completion(matchingContacts)
    }
    
    func saveContacts(contacts: [[String: String]]) {
        userDefaults?.set(contacts, forKey: DataManager.sharedSuiteName)
        userDefaults?.synchronize()
    }
}

