//
//  ContentView.swift
//  BucketList
//
//  Created by Saurabh Jamadagni on 10/11/22.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked: Bool = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked Device")
            } else {
                Text("Locked Device")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Required to access data." // This is the reason used in case of Touch ID.
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    // authenticated
                    isUnlocked = true
                } else {
                    // There was a problem with authentication.
                }
            }
        } else {
            // No biometrics.
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
