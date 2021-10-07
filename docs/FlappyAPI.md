# FlappyAPI

``` swift
public struct FlappyAPI 
```

## Initializers

### `init(endpoint:)`

``` swift
public init(endpoint: String) 
```

## Methods

### `getLeaderBoard(userAmount:)`

``` swift
public func getLeaderBoard(userAmount: Int) -> [PublicUser] 
```

### `getInt()`

``` swift
public func getInt() -> Int 
```

### `signup(_:)`

``` swift
public func signup(_ signupDetails: Signup) -> SignupError? 
```

### `login(_:_:compleation:)`

``` swift
public func login(_ name: String, _ password: String, compleation: @escaping(Result<PublicUser, APIError>) -> Void) 
```

### `submitScore(_:_:_:)`

``` swift
public func submitScore(_ name: String, _ password: String, _ score: Score) 
```

### `getUserID(_:)`

``` swift
public func getUserID(_ name: String) -> String? 
```

### `ban(_:_:_:_:)`

``` swift
public func ban(_ name: String, _ password: String, _ id: String, _ reason: String? = nil) 
```

### `unban(_:_:_:)`

``` swift
public func unban(_ name: String, _ password: String, _ id: String) 
```

### `restoreScore(_:_:_:_:)`

``` swift
public func restoreScore(_ name: String, _ password: String, _ id: String, _ score: Int = 0) 
```

### `ping(_:_:)`

``` swift
public func ping(_ name: String, _ password: String) 
```

### `createAuthHeader(_:_:)`

``` swift
public func createAuthHeader(_ name: String, _ password: String) -> String 
```
