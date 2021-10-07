//
//  Score.swift
//  Flappy Bird
//
//  Created by Brandon Plank on 9/26/21.
//  Copyright © 2021 Brandon Plank & Thatcher Clough. All rights reserved.
//

import Foundation

public extension FlappyAPI {
    final class ScoreEncrypted: Codable {
        public var score: String
        public var time: String
        
        init(_ score: String, _ time: String) {
            self.score = score
            self.time = time
        }
    }

    final class Score: Codable {
        public var score: Int
        public var time: Int
        
        init(_ score: Int, _ time: Int) {
            self.score = score
            self.time = time
        }
    }

}
