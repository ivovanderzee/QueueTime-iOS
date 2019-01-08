//
//  IntentHandler.swift
//  QueueTime Siri
//
//  Created by Rens de Meulemeester on 28/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//


// library that I used to integrate Siri in the application
import Intents


class IntentHandler: INExtension, INStartAudioCallIntentHandling{
    
    
    func handle(intent: INStartAudioCallIntent, completion: @escaping (INStartAudioCallIntentResponse) -> Void) {
        
        // Print test in console
        print("Test", intent)
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INStartAudioCallIntent.self))
        
        let response = INStartAudioCallIntentResponse(code: .continueInApp, userActivity: userActivity)
        completion(response)
        
        // When Siri completes the action, the user returns to the app
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
    
    

