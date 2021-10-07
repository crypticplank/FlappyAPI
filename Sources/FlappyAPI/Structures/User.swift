//
//  User.swift
//  Flappy Bird
//
//  Created by Brandon Plank on 9/26/21.
//  Copyright © 2021 Brandon Plank & Thatcher Clough. All rights reserved.
//

import Foundation

public extension FlappyAPI {
    final class User: Codable {
        var id: UUID?
        var name: String
        var score: Int?
        var deaths: Int?
        var passwordHash: String
        var jailbroken: Bool?
        var hasHackedTools: Bool?
        var ranInEmulator: Bool?
        var hasModifiedScore: Bool?
        var isBanned: Bool?
        
        init(id: UUID? = UUID(), name: String, score: Int? = 0, deaths: Int? = 0, passwordHash: String, jailbroken: Bool? = false, hasHackedTools: Bool? = false, ranInEmulator: Bool? = false, hasModifiedScore: Bool? = false, isBanned: Bool? = false) {
            self.id = id
            self.name = name
            self.score = score
            self.deaths = deaths
            self.passwordHash = passwordHash
            self.jailbroken = jailbroken
            self.hasHackedTools = hasHackedTools
            self.ranInEmulator = ranInEmulator
            self.hasModifiedScore = hasModifiedScore
            self.isBanned = isBanned
        }
    }

    final class PublicUser: Codable {
        var id: UUID?
        var name: String
        var score: Int?
        var deaths: Int?
        
        init(id: UUID? = UUID(), name: String, score: Int? = 0, deaths: Int? = 0) {
            self.id = id
            self.name = name
            self.score = score
            self.deaths = deaths
        }
    }
}
