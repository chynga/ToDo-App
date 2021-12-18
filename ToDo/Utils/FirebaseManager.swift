//
//  FirebaseManager.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 16.12.2021.
//

import Foundation
import Firebase

class FirebaseManager: NSObject {
    
    let auth: Auth
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
}
