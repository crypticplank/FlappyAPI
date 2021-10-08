//
//  Score.swift
//  Flappy Bird
//
//  Created by Brandon Plank on 9/26/21.
//  Copyright © 2021 Brandon Plank & Thatcher Clough. All rights reserved.
//

import Foundation

public extension FlappyAPI {
    
    final class VerifiedScore: Codable {
        public var score: Int
        public var time: Int
        public var verify: String
        
        public init(_ score: Int, _ time: Int, _ verify: String) {
            self.score = score
            self.time = time
            self.verify = verify
        }
    }
    
    final class Score: Codable {
        public var score: Int
        public var time: Int
        
        public init(_ score: Int, _ time: Int) {
            self.score = score
            self.time = time
        }
    }
}
