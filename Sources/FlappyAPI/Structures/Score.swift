//
//  Score.swift
//  Flappy Bird
//
//  Created by Brandon Plank on 9/26/21.
//  Copyright © 2021 Brandon Plank & Thatcher Clough. All rights reserved.
//

import Foundation

final public class ScoreEncrypted: Codable {
    var score: String
    var time: String
    
    init(_ score: String, _ time: String) {
        self.score = score
        self.time = time
    }
}

final public class Score: Codable {
    var score: Int
    var time: Int
    
    init(_ score: Int, _ time: Int) {
        self.score = score
        self.time = time
    }
}
