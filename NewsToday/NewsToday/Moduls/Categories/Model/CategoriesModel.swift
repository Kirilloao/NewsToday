import UIKit

struct Category {
    let name: String
    let emoji: String
    let id: Int
}

struct Categories {
    static let all = [
        Category(name: "Sports".localized(), emoji: "🏈", id: 0),
        Category(name: "Life".localized(), emoji: "🌞", id: 1),
        Category(name: "Animals".localized(), emoji: "🐻", id: 2),
        Category(name: "Food".localized(), emoji: "🍔", id: 3),
        Category(name: "History".localized(), emoji: "📜", id: 4),
        Category(name: "Middle East".localized(), emoji: "⚔️", id: 5),
        Category(name: "Politics".localized(), emoji: "⚖️", id: 6),
        Category(name: "Fashion".localized(), emoji: "👗", id: 7),
        Category(name: "Gaming".localized(), emoji: "🎮", id: 8),
        Category(name: "Technology".localized(), emoji: "💻", id: 9),
        Category(name: "Art".localized(), emoji: "🎨", id: 10),
        Category(name: "Travel".localized(), emoji: "✈️", id: 11)
        
    ]
}
