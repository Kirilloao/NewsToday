import Foundation

extension String {
    
    func localized() -> String {
        guard let languageCode = UserDefaults.standard.string(forKey: "selectedLanguage"),
              let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: bundlePath) else {
            return NSLocalizedString(self, comment: "")
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
