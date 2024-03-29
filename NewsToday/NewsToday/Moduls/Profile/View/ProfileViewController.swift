import UIKit

protocol ProfileViewControllerProtocol: AnyObject {

}

/*

1.  DONE 
 присвоение цвета осуществляется через extension (см.папку Extensions), там есть цвет .greyLighter, который можно использовать по всему проекту. Таким образом, не надо будет постоянно писать цвет по rgb в коде + можно будет поменять этот цвет в два касания

 2. DONE
 тексты кнопок должны быть реализованы через .makeLabel, не UITextView. Сейчас пользователь может стереть этот текст из кнопок

 3. DONE
 картинки (стрелки, log out) лучше добавить в ассеты и вытягивать по имени. Это тоже обеспечит простой доступ и возможность легко изменить картинку по всему проекту

 4. DONE
 добавление элементов на экран и констрейнты лучше разнести по разным функциям, например setupView() и setupConstraints(). Это будет соответствовать принципу разделения ответственности по SOLID

 5. DONE
 большое количество элементов можно добавить на экран с помощью массива этих самых элементов и перебора, например: [label, label, view].forEach { view.addSubview($0) }

 6. DONE
 поправить вёрстку под SE (запусти на симуляторе через SE, увидишь куда уехало). Адаптивный лэйаут строится на том, что мы задаём длину/ширину элементов и их расположение, отталкиваясь от safeAreaLayoutGuide (в данном случае можно начать размещать нижнюю кнопку от view.bottom. Мы не задаём ширину width, а прибиваем левый и правый края вью относительно основной вью:

 languageButton.snp.makeConstraints { make in
     make.leading.trailing.equalToSuperview().inset(20)
     make.top.equalTo(view.safeAreaLayoutGuide).inset(208)
     make.height.equalTo(56)
 }
 */


final class ProfileViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: ProfilePresenterProtocol!
    
    
    // MARK: - UI Elements
    
    let profileTitle = UILabel.makeLabel(text: "Profile",
                                      font: UIFont.InterBold(ofSize: 24),
                                      textColor: .blackPrimary,
                                      numberOfLines: nil)
        
        let pageTitle = UIView()
    
    private lazy var languageButton: UIButton = {
        var config = UIButton.Configuration.plain()
 
        config.image = UIImage(named: "Rightangle")
        config.imagePlacement = .trailing
        config.imagePadding = self.calculateDynamicPadding()
        
        let button = UIButton(configuration: config, primaryAction: nil)
        button.setTitle("Language", for: .normal)
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.font = .InterSemiBold(ofSize: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = .greyLighter
        button.tintColor = .darkGray
        return button
      }()
    
    private func calculateDynamicPadding() -> CGFloat {
           let screenWidth = UIScreen.main.bounds.width
           
           if screenWidth > 500 {
               return 250
           } else {
               return 200
           }
       }
    
    
    
    private let profileImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "ProfileFoto")
        element.layer.cornerRadius = 35
        element.clipsToBounds = true
        return element
    }()

    private let profileName = UILabel.makeLabel(text: "Dev P",
                                                font: UIFont.InterSemiBold(ofSize: 16),
                                                textColor: UIColor.blackDark,
                                                numberOfLines: 1)
    
    private let profileEmail = UILabel.makeLabel(text: "dev@gmail.com",
                                                 font: UIFont.InterSemiBold(ofSize: 14),
                                                 textColor: UIColor.greyLight,
                                                 numberOfLines: 1)
             
    private lazy var termsButton: UIButton = {
        var config = UIButton.Configuration.plain()
 
        config.image = UIImage(named: "Rightangle")
        config.imagePlacement = .trailing
        config.imagePadding = self.calculateDynamicPadding()
        
        let button = UIButton(configuration: config, primaryAction: nil)
        button.setTitle("Terms & Conditions", for: .normal)
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.font = .InterSemiBold(ofSize: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = .greyLighter
        button.tintColor = .darkGray
        return button
      }()
    
    private lazy var signoutButton: UIButton = {
        var config = UIButton.Configuration.plain()
 
        config.image = UIImage(named: "SignOut")
        config.imagePlacement = .trailing
        config.imagePadding = self.calculateDynamicPadding()
        
        let button = UIButton(configuration: config, primaryAction: nil)
        button.setTitle("Sign Out", for: .normal)
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.font = .InterSemiBold(ofSize: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = .greyLighter
        button.tintColor = .darkGray
        return button
      }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
    }
    
    
    //MARK: Private Methods
    private func setupViews() {
        
        [languageButton, profileTitle, pageTitle, profileImage, profileName, profileEmail, termsButton, signoutButton].forEach { view.addSubview($0)}
    }
    
    private func setupConstraints() {
        
        languageButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(208)
            make.height.equalTo(56)
        }
        
        profileTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(28)
            make.left.equalTo(view).inset(20)
        }
        
        pageTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(28)
            make.left.equalTo(view).inset(20)
            make.width.equalTo(201)
            make.height.equalTo(136)
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(92)
            make.left.equalTo(view).inset(20)
            make.width.equalTo(72)
            make.height.equalTo(72)
        }
        
        profileName.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(104)
            make.left.equalTo(view).inset(116)
            make.width.equalTo(60)
            make.height.equalTo(24)
        }
        
        profileEmail.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(128)
            make.left.equalTo(view).inset(116)
            make.width.equalTo(115)
            make.height.equalTo(24)
        }
        
        termsButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view).inset(208)
            make.height.equalTo(56)
        }
        
        signoutButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view).inset(124)
            make.height.equalTo(56)
        }
    }
}
