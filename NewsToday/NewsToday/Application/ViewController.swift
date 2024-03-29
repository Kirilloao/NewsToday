import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let userDefaultsManager = UserDefaultsManager()
    // MARK: - UI Elements
    let label = UILabel.makeLabel(text: "Hello, world!".localized(),
                                  font: UIFont.InterBold(ofSize: 20),
                                  textColor: .blackLight,
                                  numberOfLines: nil)
    
    let englishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("English", for: .normal)
        button.addTarget(self, action: #selector(changeLanguageToEnglish), for: .touchUpInside)
        return button
    }()
    
    let russianButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Russian", for: .normal)
        button.addTarget(self, action: #selector(changeLanguageToRussian), for: .touchUpInside)
        return button
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purpleLight
        layout()
        //        topHeadlinesTest()
        //        search()
//        loadAndFetchCategories()
        
    }
    
    /// Отправляет запрос к API для получения данных и обрабатывает результаты.
    private func search() {
        NetworkManager.shared.fetchData(for: "Apple") { result in
            switch result {
            case .success(let search):
                print("Results: \(search)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    private func topHeadlinesTest() { NetworkManager.shared.fetchTopHeadlines(category: "technology") { result in
        switch result {
        case .success(let category):
            print("Results: \(category)")
        case .failure(let error):
            print("Error: \(error)")
        }
    }
    }
    
    func loadAndFetchCategories() {
        // Извлекаем сохранённые категории из UserDefaults
        if let savedCategories = userDefaultsManager.getStringArray(forKey: .selectedCategories) {
            // Передаём сохранённые категории в метод fetchCategories
            NetworkManager.shared.fetchCategories(for: savedCategories) { categoryName, result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let searchResults):
                        print("Results for \(categoryName):", searchResults)
                    case .failure(let error):
                        print("Error fetching data for \(categoryName):", error)
                    }
                }
            }
        }
    }
    // MARK: - @Objc methods    Методы для Андрея
    @objc func changeLanguageToEnglish() {
        userDefaultsManager.set("en", forKey: .selectedLanguage)
        showAlertToRestartApp()
    }
    
    @objc func changeLanguageToRussian() {
        userDefaultsManager.set("ru", forKey: .selectedLanguage)
        showAlertToRestartApp()
    }
    
    private func showAlertToRestartApp() {
        let alert = UIAlertController(title: "Language Change",
                                      message: "Please restart the app to apply the new language.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        
        present(alert, animated: true)
    }
    
        //MARK: Private Methods
        private func layout() {
            view.addSubview(label)
            view.addSubview(englishButton)
            view.addSubview(russianButton)
                            
            label.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
                            
                englishButton.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(20)
                make.centerX.equalToSuperview().offset(-50)
            }
                            
                russianButton.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(20)
                make.centerX.equalToSuperview().offset(50)
            }
        }
    }

