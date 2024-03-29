import UIKit

protocol BookmarksPresenterProtocol {
    var bookmarkCount: Int { get }
    func getBookmark(at index: Int) -> Article
    func viewDidLoad()
    func didEditingDelete(at indexPath: IndexPath)
    func retrieveBookmarks()
}

final class BookmarksPresenter: BookmarksPresenterProtocol {
    weak private var bookmarksViewControllerProtocol: BookmarksViewControllerProtocol?
    
    var bookmarks: [Article] = []
    
    init(bookmarksViewControllerProtocol: BookmarksViewControllerProtocol? = nil) {
        self.bookmarksViewControllerProtocol = bookmarksViewControllerProtocol
    }
    
    var bookmarkCount: Int {
        return bookmarks.count
    }
    
    func getBookmark(at index: Int) -> Article {
        return bookmarks[index]
    }
    
    
    func viewDidLoad() {
        bookmarksViewControllerProtocol?.reloadTableView()
        retrieveBookmarks()
    }

    func didEditingDelete(at indexPath: IndexPath) {
        guard let articleToSave = bookmarks.first else { return }
        PersistenceManager.updateWith(favorite: articleToSave, actionType: .remove) {
      
            error in
    
                   
                   if let error = error as? PersistenceError, error == .alreadyInFavorites {
                       print("Article is already in favorites")
                   } else if let error = error {
                       print("Error saving article: \(error)")
                   } else {
                       print("Article saved to favorites")
                   }
               }
        
//        PersistenceManager.updateWith(favorite: articleToSave, actionType: .remove) { error in
//            if let error = error {
//                                   print("Error saving article: \(error)")
//                               }
//        }
        
        
        bookmarks.remove(at: indexPath.row)
        bookmarksViewControllerProtocol?.reloadTableView()
        
    }
    
    func retrieveBookmarks() {
         PersistenceManager.retrieveFavorites { [weak self] result in
             guard let self = self else { return }
             switch result {
             case .success(let favorites):
                 self.bookmarks = favorites
                 self.bookmarksViewControllerProtocol?.reloadTableView()
             case .failure(let error):
                 print(error)
             }
         }
     }
}
