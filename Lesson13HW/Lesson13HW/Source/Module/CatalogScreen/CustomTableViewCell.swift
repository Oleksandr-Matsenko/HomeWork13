//
//  CustomTableViewCell.swift
//  Lesson13HW
//
//  Created by Alex Matsenko on 16.04.2024.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "CustomCellTableViewCell"
    
    // MARK: - UI Elements
    
    private lazy var placeholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: Constant.ImageSize.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constant.ImageSize.heigth).isActive = true
        return imageView
    }()
    private lazy var productCodeLabel = UIBuilder.createLabel(font: Constant.Labels.titleFont, textColor: Constant.Labels.textColor)
    private lazy var nameLabel = UIBuilder.createLabel(font: Constant.Labels.titleFont, textColor: Constant.Labels.textColor)
    private lazy var manufacturedLabel = UIBuilder.createLabel(font: Constant.Labels.titleFont, textColor: Constant.Labels.textColor)
    private lazy var modelLabel = UIBuilder.createLabel(font: Constant.Labels.titleFont, textColor: Constant.Labels.textColor)
    private lazy var ratingLabel = UIBuilder.createLabel(font: Constant.Labels.ratingFont, textColor: Constant.Labels.textColor)
    private lazy var sellingLabel = UIBuilder.createLabel(font: Constant.Labels.titleFont, textColor: Constant.Labels.textColor)
    private lazy var priceLabel = UIBuilder.createLabel(font: Constant.Labels.titleFont, textColor: Constant.Labels.textColor)
    private lazy var currencyLabel = UIBuilder.createLabel(font: Constant.Labels.titleFont, textColor: Constant.Labels.textColor)
    private lazy var addToFavorite: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "toFavorite"), for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.addTarget(self, action: #selector(savedToFavorite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var toFavoriteLabel = UIBuilder.createLabel(font: Constant.Labels.titleFont, textColor: .systemRed)
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
private enum Constant {
    enum ImageSize {
        static let width: CGFloat = 100
        static let heigth: CGFloat = 100
    }
    enum Labels {
        static let titleFont: UIFont = UIFont.boldSystemFont(ofSize: 15)
        static let textColor: UIColor = .black
        static let ratingFont: UIFont = UIFont.boldSystemFont(ofSize: 12)
    }
}


