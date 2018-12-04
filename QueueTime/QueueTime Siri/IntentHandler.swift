//
//  IntentHandler.swift
//  QueueTime Siri
//
//  Created by Rens de Meulemeester on 28/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//

import Intents


class IntentHandler: INExtension, INStartAudioCallIntentHandling{
    
    
    func handle(intent: INStartAudioCallIntent, completion: @escaping (INStartAudioCallIntentResponse) -> Void) {
        
    
        print("Bel via QueueTime", intent)
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INStartAudioCallIntent.self))
        
        let response = INStartAudioCallIntentResponse(code: .continueInApp, userActivity: userActivity)
        completion(response)
        
        
         completion(INStartAudioCallIntentResponse(code: .continueInApp, userActivity: userActivity))
        
    }
    
    
    func resolveContacts(for intent: INStartAudioCallIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
        
        var contactName: String?
        
        if let contacts = intent.contacts {
            contactName = contacts.first?.displayName
        }
        
        DataManager.sharedManager.findContact(contactName: contactName, with: { (contacts) in
            
            switch contacts.count {
                
            case 1:
                completion([INPersonResolutionResult.success(with: contacts.first!)])
            case 2 ... Int.max:
                completion([INPersonResolutionResult.disambiguation(with: contacts)])
            default:
                completion([INPersonResolutionResult.unsupported()])
            }
            
        })
    }
    
    func confirm(intent: INStartAudioCallIntent, completion: @escaping (INStartAudioCallIntentResponse) -> Void) {
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INStartAudioCallIntent.self))
        let response = INStartAudioCallIntentResponse(code: .ready, userActivity: userActivity)
        completion(response)
    }

    }
    
    

