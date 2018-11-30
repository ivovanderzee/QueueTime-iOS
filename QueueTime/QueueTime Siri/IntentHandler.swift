//
//  IntentHandler.swift
//  QueueTime Siri
//
//  Created by Rens de Meulemeester on 28/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//

import Intents

class IntentHandler: INExtension, INAskSiriIntentHandling {
    func handle(startInfo intent: INAskSiriIntent, completion: @escaping (INAskSiriIntentResponse) -> Void) {

        print("Ik sta in de file", intent)
        
        let userActivity: NSUserActivity? = nil
        guard let spokenPhrase = intent.placeName?.spokenPhrase else {
            completion(INAskSiriIntentResponse(code: .failureNoMatchingWorkout, userActivity: userActivity))
            return
        }
        
        print(spokenPhrase)
        
        completion(INAskSiriIntentResponse(code: .continueInApp, userActivity: userActivity))
        
    }
    
    
}
