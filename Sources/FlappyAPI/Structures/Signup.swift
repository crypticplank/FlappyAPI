//
//  Signup.swift
//  Flappy Bird
//
//  Created by Brandon Plank on 9/26/21.
//  Copyright © 2021 Brandon Plank & Thatcher Clough. All rights reserved.
//

import Foundation

public extension FlappyAPI {
    final class Signup: Codable {
        var name: String
        var password: String
        var confirmPassword: String
        
        init(_ name: String, _ password: String, _ confirmPassword: String) {
            self.name = name
            self.password = password
            self.confirmPassword = password
        }
    }
}
