import UIKit

// MARK: ProfileModuleBuilderProtocol

protocol ProfileModuleBuilderProtocol {
    func createProfileModule(router: ProfileRouterProtocol) -> UIViewController
    func createTermsVC() -> UIViewController
    func createLanguagesVC() -> UIViewController
}

// MARK: Profile Builder

final class ProfileModuleBuilder: ProfileModuleBuilderProtocol {

    func createProfileModule(router: ProfileRouterProtocol) -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view as! ProfileViewControllerProtocol, router: router)
        view.presenter = presenter
        return view
    }

    func createTermsVC() -> UIViewController {
        TermsVC()
    }

    func createLanguagesVC() -> UIViewController {
        let view = LanguageViewController()
//        let presenter = LanguagePresenter(view: view as! LanguageViewControllerProtocol, router)
//        view.presenter = presenter
        return view
    }
}
