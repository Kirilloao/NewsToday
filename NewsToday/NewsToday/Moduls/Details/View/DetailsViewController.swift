import UIKit
import SnapKit

protocol DetailsViewControllerProtocol: AnyObject {
    func setupData(with data: ([Article]))
    func displayData()
}

final class DetailsViewController: UIViewController, DetailsViewControllerProtocol, UITextViewDelegate, UIScrollViewDelegate {
    
    //MARK: - Presenter
    private let presenter = DetailsPresenter()
    
    
    //MARK: - Private properties
    var data: [Article] = []
    weak private var detailsPresenterProtocol: DetailsPresenterProtocol?
    
    //MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    private let contentImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image")
       image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "share-icon"), for: .normal)
        return button
    }()
    
    private let labelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.purplePrimary
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let categoryLabel = UILabel.makeLabel(font: UIFont.InterSemiBold(ofSize: 12),
                                                  textColor: .white,
                                                  numberOfLines: 1)
    private let headlineLabel = UILabel.makeLabel(font: UIFont.InterBold(ofSize: 20),
                                                  textColor: .white,
                                                  numberOfLines: 2)
    private let authorLabel = UILabel.makeLabel(font: UIFont.InterSemiBold(ofSize: 16),
                                                textColor: .white,
                                                numberOfLines: 1)
    private let authorGreyLabel = UILabel.makeLabel(text: "Author",
                                                    font: UIFont.InterRegular(ofSize: 14), textColor: UIColor.greyLight,
                                                    numberOfLines: 1)
    private let titleLabel = UILabel.makeLabel(font: UIFont.InterSemiBold(ofSize: 16),
                                               textColor: UIColor.blackPrimary,
                                               numberOfLines: 0)
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.InterRegular(ofSize: 16)
        textView.textColor = UIColor.greyDark
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        presenter.setDetailsViewControllerProtocol(detailsViewControllerProtocol: self)
        self.detailsPresenterProtocol = presenter
        self.detailsPresenterProtocol?.getData(with: data)
        configureController()
        setNavigationBar(title: "")
     
    }
    // MARK: - Public Methods
    func setupData(with data: ([Article])) {
        self.data = data
        
    }
    
    func displayData() {
        categoryLabel.text = data.first?.source.name
        headlineLabel.text = data.first?.title
        authorLabel.text = data.first?.author
        titleLabel.text = data.first?.title
        contentTextView.text = data.first?.content
        
    }
    
    @objc func bookmarkButtonTapped() {
        
    }
    
    @objc func shareButtonTapped() {
        guard let textToShare = contentTextView.text else { return }
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: Private methods
    private func setupViews() {
        [contentImage, shareButton, labelView, categoryLabel, headlineLabel, authorLabel, authorGreyLabel, titleLabel, contentTextView].forEach {contentView.addSubview($0) }
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        labelView.addSubview(categoryLabel)
    }
    
    private func configureController() {
        let bookmarkButton = UIBarButtonItem(image: UIImage(named: "bookmark-icon"), style: .plain, target: self, action: #selector(bookmarkButtonTapped))
        bookmarkButton.tintColor = .white
        navigationItem.rightBarButtonItem = bookmarkButton
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        view.backgroundColor = .systemBackground
        contentTextView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }

        contentImage.snp.makeConstraints { make in
          make.top.equalToSuperview()
          make.leading.trailing.equalToSuperview()
            
        }
        shareButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        labelView.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(32) 
            make.width.equalTo(categoryLabel.snp.width).offset(20)
            make.height.equalTo(32)
            make.top.equalToSuperview().offset(168)
            make.leading.equalToSuperview().offset(20)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        headlineLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(216)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(296)
            make.leading.equalToSuperview().offset(26)
        }
        
        authorGreyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(320)
            make.leading.equalToSuperview().offset(26)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentImage.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
    
}
