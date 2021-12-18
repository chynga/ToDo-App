//
//  UserModel.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 17.12.2021.
//

import Foundation

struct User {
    let uid, email: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
    }
}
