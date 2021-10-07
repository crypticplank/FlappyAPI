# FlappyAPI.User

``` swift
final class User: Codable 
```

## Inheritance

`Codable`

## Initializers

### `init(id:name:score:deaths:passwordHash:jailbroken:hasHackedTools:ranInEmulator:hasModifiedScore:isBanned:)`

``` swift
public init(id: UUID? = UUID(), name: String, score: Int? = 0, deaths: Int? = 0, passwordHash: String, jailbroken: Bool? = false, hasHackedTools: Bool? = false, ranInEmulator: Bool? = false, hasModifiedScore: Bool? = false, isBanned: Bool? = false) 
```

## Properties

### `id`

``` swift
public var id: UUID?
```

### `name`

``` swift
public var name: String
```

### `score`

``` swift
public var score: Int?
```

### `deaths`

``` swift
public var deaths: Int?
```

### `passwordHash`

``` swift
public var passwordHash: String
```

### `jailbroken`

``` swift
public var jailbroken: Bool?
```

### `hasHackedTools`

``` swift
public var hasHackedTools: Bool?
```

### `ranInEmulator`

``` swift
public var ranInEmulator: Bool?
```

### `hasModifiedScore`

``` swift
public var hasModifiedScore: Bool?
```

### `isBanned`

``` swift
public var isBanned: Bool?
```
