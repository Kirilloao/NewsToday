import Foundation

// Конфигурация API и токенов доступа
struct API {
    static let scheme = "https"
    static let host = "newsapi.org"
    static let apiKey = Token.third
}

struct Token {
    // сюда надо будет добавлять ключи по мере надобности, если буду заканчиваться запросы
    static let first = "55c555f55ce34b2aa8090f1e25017ddd"
    static let second = "195a5aebba54417e8a7f91ed37e90ac9"
    static let third = "7ac0355e92e64567855eb84c387ea75d"
}

