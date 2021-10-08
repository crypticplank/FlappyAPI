import Foundation
import FlappyEncryption

public struct FlappyAPI {
    #if DEBUG
    let apiURL = "http://127.0.0.1"
    #else
    let apiURL = "https://flappybird.brandonplank.org"
    #endif
    let resourceURL: URL
    
    public enum APIError:Error {
        case success
        case responseProblem
        case decodingProblem
        case encodingProblem
        case userExists
        case otherProblem
    }

    public class SignupError: Codable {
        public var error: Bool?
        public var reason: String?
    }
    
    public init(endpoint: String) {
        let resourceString = "\(apiURL)/\(endpoint)"
        guard let url: URL = URL(string: resourceString) else { fatalError() }
        self.resourceURL = url
    }
    
    public func getLeaderBoard(userAmount: Int) -> [PublicUser] {
        var users = [PublicUser]()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        do {
            var urlRequest = URLRequest(url: URL(string: "\(resourceURL.absoluteString)/\(userAmount)" )!)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    return
                }
                do {
                    users = try JSONDecoder().decode([PublicUser].self, from: jsonData)
                    semaphore.signal()
                } catch {
                    #if DEBUG
                    print("Failed to decode leaderboard Public User")
                    #endif
                }
            }
            dataTask.resume()
            semaphore.wait()
        }
        return users
    }
    
    public func getInt() -> Int {
        var count = 0
        
        let semaphore = DispatchSemaphore(value: 0)
        
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                    return
                }
                do {
                    let stringCount = String(data: data, encoding: .utf8)
                    count = Int(stringCount ?? "") ?? 0
                    semaphore.signal()
                }
            }
            dataTask.resume()
            semaphore.wait()
        }
        return count
    }
    
    public func signup(_ signupDetails: Signup) -> SignupError? {
        
        var error: SignupError? = nil
        
        let semaphore = DispatchSemaphore(value: 0)
        
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(signupDetails)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
                guard let jsonData = data else {
                    return
                }
                do {
                    error = try JSONDecoder().decode(SignupError.self, from: jsonData)
                    semaphore.signal()
                } catch {
                }
            }
            dataTask.resume()
            semaphore.wait()
        } catch {
            return nil
        }
        return error
    }
    
    public func login(_ name: String, _ password: String, compleation: @escaping(Result<PublicUser, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue(createAuthHeader(name, password), forHTTPHeaderField: "Authorization")
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    compleation(.failure(.responseProblem))
                    return
                }
                do {
                    let userData = try JSONDecoder().decode(PublicUser.self, from: jsonData)
                    #if DEBUG
                    print(userData)
                    #endif
                    compleation(.success(userData))
                } catch {
                    compleation(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }
    }
    
    public func submitScore(_ name: String, _ password: String, _ score: Score) {
        #if DEBUG
        print("Score: \(score.score)")
        print("Time: \(score.time)")
        #endif
        let score = FlappyAPI.VerifiedScore(score.score, score.time, FlappyEncryption.genHash(score.score, score.time))
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue(createAuthHeader(name, password), forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(score)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
            }
            dataTask.resume()
        } catch {
        }
    }
    
    public func getUserID(_ name: String) -> String? {
        var uuid: String? = nil
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var urlRequest = URLRequest(url: URL(string: "\(resourceURL.absoluteString)/\(name)")!)
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
            guard let data = data else {
                return
            }
            uuid = String(bytes: data, encoding: .utf8)
            semaphore.signal()
        }
        dataTask.resume()
        semaphore.wait()
        return uuid
    }
    
    public func ban(_ name: String, _ password: String, _ id: String, _ reason: String? = nil) {
        var urlRequest = URLRequest(url: URL(string: "\(resourceURL.absoluteString)/\(id)/\(reason ?? "Not Specified")")!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(createAuthHeader(name, password), forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
        }
        dataTask.resume()
    }
    
    public func unban(_ name: String, _ password: String, _ id: String) {
        var urlRequest = URLRequest(url: URL(string: "\(resourceURL.absoluteString)/\(id)")!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(createAuthHeader(name, password), forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
        }
        dataTask.resume()
    }
    
    public func deleteUser(_ name: String, _ password: String, _ id: String) {
        var urlRequest = URLRequest(url: URL(string: "\(resourceURL.absoluteString)/\(id)")!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(createAuthHeader(name, password), forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
        }
        dataTask.resume()
    }
    
    public func restoreScore(_ name: String, _ password: String, _ id: String, _ score: Int = 0) {
        var urlRequest = URLRequest(url: URL(string: "\(resourceURL.absoluteString)/\(id)/\(score)")!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(createAuthHeader(name, password), forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
        }
        dataTask.resume()
    }
    
    public func ping(_ name: String, _ password: String) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue(createAuthHeader(name, password), forHTTPHeaderField: "Authorization")
            let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
            }
            dataTask.resume()
        }
    }
    
    public func getUsers(_ name: String, _ password: String) -> [User]? {
        
        var users: [User]?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue(createAuthHeader(name, password), forHTTPHeaderField: "Authorization")
            let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
                guard let jsonData = data else {
                    return
                }
                do {
                    users = try JSONDecoder().decode([User].self, from: jsonData)
                    semaphore.signal()
                } catch {
                }
            }
            dataTask.resume()
            semaphore.wait()
        }
        return users
    }
    
    public func createAuthHeader(_ name: String, _ password: String) -> String {
        let loginString = String(format: "%@:%@", name, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        return "Basic \(base64LoginString)"
    }
}
