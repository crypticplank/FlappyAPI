import XCTest
@testable import FlappyAPI

let username = "Test"
let password = "TestingAccount"

final class FlappyAPITests: XCTestCase {
    
//    func testRegisterTestAccount() {
//        FlappyAPI(endpoint: "registerUser").signup(FlappyAPI.Signup(username, password, password))
//    }
    
    func testGetID() {
        print("Running getid test")
        print("ID: \(FlappyAPI(endpoint: "getID").getUserID(username)!)")
    }

    func testGetDeaths() {
        print("Running deaths test")
        print("Deaths: \(FlappyAPI(endpoint: "globalDeaths").getInt())")
    }

    func testGetUsers() {
        print("Running users test")
        print("Users: \(FlappyAPI(endpoint: "userCount").getInt())")
    }

    func testGetPasswordHashes() {
        print("Running Password hashes")
        let users = FlappyAPI(endpoint: "internal_users").getUsers(username, password)
        guard let users = users else {
            print("Failed to get users")
            return
        }

        for flappyuser in users {
            print("\(flappyuser.name): \nHash: \(flappyuser.passwordHash) \nScore: \(flappyuser.score ?? 0)\nDeaths: \(flappyuser.deaths!)\n")
        }
    }

    func testUnban() {
        FlappyAPI(endpoint: "unban").unban(username, password, FlappyAPI(endpoint: "getID").getUserID(username)!)
    }

    func testRestoreScore() {
        FlappyAPI(endpoint: "restoreScore").restoreScore(username, password, FlappyAPI(endpoint: "getID").getUserID(username)!, 420)
    }

    func testSubmitScore() {
        FlappyAPI(endpoint: "submitScore").submitScore(username, password, FlappyAPI.Score(420, 420))
    }
}
