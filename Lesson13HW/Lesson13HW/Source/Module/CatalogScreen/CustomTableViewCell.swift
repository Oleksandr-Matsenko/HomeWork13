//
//  CustomTableViewCell.swift
//  Lesson13HW
//
//  Created by Alex Matsenko on 16.04.2024.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {
    
    
    // MARK: - UI Components
    private lazy var placeholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    private lazy var productCodeLabel = UIBuilder.createLabel(font: .systemFont(ofSize: 15, weight: .bold), textColor: .black)
    private lazy var nameLabel = UIBuilder.createLabel(font: .systemFont(ofSize: 15, weight: .bold), textColor: .black)
    private lazy var manufacturedLabel = UIBuilder.createLabel(font: .systemFont(ofSize: 15, weight: .bold), textColor: .black)
    private lazy var modelLabel = UIBuilder.createLabel(font: .systemFont(ofSize: 15, weight: .bold), textColor: .black)
    private lazy var ratingLabel = UIBuilder.createLabel(font: .systemFont(ofSize: 12), textColor: .black)
    private lazy var sellingLabel = UIBuilder.createLabel(font: .systemFont(ofSize: 15), textColor: .black)
    private lazy var priceLabel = UIBuilder.createLabel(font: .systemFont(ofSize: 15, weight: .bold), textColor: .black)
    private lazy var currencyLabel = UIBuilder.createLabel(font: .systemFont(ofSize: 15, weight: .bold), textColor: .black)
    private lazy var addToFavorite: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "toFavorite"), for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.addTarget(self, action: #selector(savedToFavorite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var toFavoriteLabel = UIBuilder.createLabel(font: .systemFont(ofSize: 12, weight: .bold), textColor: .systemRed)
    private lazy var toFavoriteStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 7
        stack.translatesAutoresizingMaskIntoConstraints = false
        [addToFavorite, toFavoriteLabel,].forEach{
            stack.addArrangedSubview($0)}
        return stack
    }()
    private lazy var productInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        [productCodeLabel, nameLabel, manufacturedLabel, modelLabel].forEach{
            stack.addArrangedSubview($0)}
        return stack
    }()
    private lazy var productPriceStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        [priceLabel, currencyLabel].forEach{
            stack.addArrangedSubview($0)}
        return stack
    }()
    private lazy var productImageRatingStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        [placeholderImageView, ratingLabel, sellingLabel].forEach{
            stack.addArrangedSubview($0)}
        return stack
    }()

    var favoriteButtonAction: (() -> Void)?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        [productImageRatingStackView, productInfoStackView, productPriceStackView, toFavoriteStackView].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            productImageRatingStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImageRatingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productInfoStackView.topAnchor.constraint(equalTo: productImageRatingStackView.topAnchor),
            productInfoStackView.leadingAnchor.constraint(equalTo: productImageRatingStackView.trailingAnchor, constant: 20),
            productPriceStackView.topAnchor.constraint(equalTo: productImageRatingStackView.bottomAnchor, constant: 5),
            productPriceStackView.leadingAnchor.constraint(equalTo: productImageRatingStackView.leadingAnchor),
            toFavoriteStackView.bottomAnchor.constraint(equalTo: productImageRatingStackView.bottomAnchor),
            toFavoriteStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60)
        ])
    }
    
    // MARK: - Cell Configuration
    // Setup cell for CatalogViewController
    func configurePC(pc: Pc) {
        placeholderImageView.image = UIImage(named: "mainPC")
        // Configure attributed strings for labels
        let productAttributedString = attributedString(withText: "Product code: \(pc.id)", coloredText: "\(pc.id)", color: .systemGreen)
        productCodeLabel.attributedText = productAttributedString
        let nametAttributedString = attributedString(withText: "PC type: \(pc.name)", coloredText: "\(pc.name)", color: .systemGreen)
        nameLabel.attributedText = nametAttributedString
        let manufacturedAttributedString = attributedString(withText: "Manufactured: \(pc.manufacturer)", coloredText: "\(pc.manufacturer)", color: .systemGreen)
        manufacturedLabel.attributedText = manufacturedAttributedString
        let modelAttributedString = attributedString(withText: "Model: \(pc.model)", coloredText: "\(pc.model)", color: .systemGreen)
        modelLabel.attributedText = modelAttributedString
        // Set rating label text based on rating value
        switch pc.rating {
            case 5: ratingLabel.text = "Rating: \n\(ProductQuality.excellent.rawValue) \(pc.rating)"
            case 4: ratingLabel.text = "Rating: \n\(ProductQuality.good.rawValue) \(pc.rating)"
            case 3: ratingLabel.text = "Rating: \n\(ProductQuality.preGood.rawValue) \(pc.rating)"
            default:
                ratingLabel.text = "Rating: \n\(ProductQuality.average.rawValue) \(pc.rating)"
        }
        sellingLabel.text = "Top selling: \(pc.topSelling)"
        let priceAttributedString = attributedString(withText: "Price: \(pc.price)", coloredText: "\(pc.price)", color: .systemGreen)
        priceLabel.attributedText = priceAttributedString
        currencyLabel.text = "\(pc.currency)"
        toFavoriteLabel.text = "SAVED"
        toFavoriteLabel.isHidden = true
        toFavoriteLabel.textAlignment = .center
    }
    // Setup cell for FavoriteViewController
    func configuteFavoriteItem(pc: Favorite) {
        productCodeLabel.attributedText = attributedString(withText: "Product code: \(pc.id)", coloredText: "\(pc.id)", color: .systemGreen)
        addToFavorite.isHidden = true
        placeholderImageView.isHidden = false
        placeholderImageView.image = UIImage(named: "favoriteItem")
//        placeholderImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        placeholderImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        let nametAttributedString = attributedString(withText: "\tPC type: \(pc.name)", coloredText: "\(pc.name)", color: .systemGreen)
        nameLabel.attributedText = nametAttributedString
        let manufacturedAttributedString = attributedString(withText: "\tManufactured: \(pc.manufacturer)", coloredText: "\(pc.manufacturer)", color: .systemGreen)
        manufacturedLabel.attributedText = manufacturedAttributedString
        let modelAttributedString = attributedString(withText: "\tModel: \(pc.model)", coloredText: "\(pc.model)", color: .systemGreen)
        modelLabel.attributedText = modelAttributedString
        [nameLabel, manufacturedLabel, modelLabel].forEach{$0.font = .systemFont(ofSize: 13, weight: .regular)}
//        productInfoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
      
    }

    //MARK: - Actions
    
    @objc private func savedToFavorite() {
        toFavoriteLabel.isHidden = false
        // Delay hiding the label and execute favorite button action
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {[weak self] in
            guard let self = self else {return}
            self.toFavoriteLabel.isHidden = true
            favoriteButtonAction?()
        }
        // Animate the favorite button
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
               self.addToFavorite.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
           }) { _ in
               UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                   self.addToFavorite.transform = .identity
               })
           }
    }
    
    // MARK: - Helper Methods
    
    private func attributedString(withText text: String, coloredText: String, color: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: coloredText)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return attributedString
    }
    
}


