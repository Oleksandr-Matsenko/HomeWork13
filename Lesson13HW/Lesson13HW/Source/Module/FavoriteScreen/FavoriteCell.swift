//
//  FavoriteCell.swift
//  Lesson13HW
//
//  Created by Alex Matsenko on 21.04.2024.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "FavoriteCell"
    
    // MARK: - UI Elements
    
    private lazy var favoriteItem: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: Constant.ImageSize.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constant.ImageSize.heigth).isActive = true
        return imageView
    }()
    private lazy var productCodeLabel = UIBuilder.createLabel(font: Constant.Labels.titlesFont, textColor: Constant.Labels.titleColor)
    private lazy var nameLabel = UIBuilder.createLabel(font: Constant.Labels.titlesFont, textColor: Constant.Labels.titleColor)
    private lazy var manufacturedLabel = UIBuilder.createLabel(font: Constant.Labels.titlesFont, textColor: Constant.Labels.titleColor)
    private lazy var modelLabel = UIBuilder.createLabel(font: Constant.Labels.titlesFont, textColor: Constant.Labels.titleColor)
    private lazy var infoStackLabels: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        [productCodeLabel, nameLabel, manufacturedLabel, modelLabel].forEach{
            stack.addArrangedSubview($0)
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Setup UI
    
    private func setupUI() {
        contentView.addSubview(favoriteItem)
        contentView.addSubview(infoStackLabels)
        // Constraints
        NSLayoutConstraint.activate([
            // Image
            favoriteItem.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            favoriteItem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            // StackView
            infoStackLabels.topAnchor.constraint(equalTo: favoriteItem.topAnchor),
            infoStackLabels.leadingAnchor.constraint(equalTo: favoriteItem.trailingAnchor, constant: 20)
        ])
    }
    
// MARK: - Cell Configuration
    
    func configureFavorite(pc: Favorite) {
        productCodeLabel.attributedText = attributedString(withText: "Product code: \(pc.id)", coloredText: "\(pc.id)", color: .systemGreen)
        favoriteItem.isHidden = false
        favoriteItem.image = UIImage(named: "favoriteItem")
        let nametAttributedString = attributedString(withText: "\tPC type: \(pc.name)", coloredText: "\(pc.name)", color: .systemGreen)
        nameLabel.attributedText = nametAttributedString
        let manufacturedAttributedString = attributedString(withText: "\tManufactured: \(pc.manufacturer)", coloredText: "\(pc.manufacturer)", color: .systemGreen)
        manufacturedLabel.attributedText = manufacturedAttributedString
        let modelAttributedString = attributedString(withText: "\tModel: \(pc.model)", coloredText: "\(pc.model)", color: .systemGreen)
        modelLabel.attributedText = modelAttributedString
        [nameLabel, manufacturedLabel, modelLabel].forEach{$0.font = .systemFont(ofSize: 13, weight: .regular)}
    }
    
}

// MARK: - Helper Methods

private func attributedString(withText text: String, coloredText: String, color: UIColor) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: text)
    let range = (text as NSString).range(of: coloredText)
    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    return attributedString
}

private enum Constant {
    enum ImageSize {
        static let width: CGFloat = 100
        static let heigth: CGFloat = 100
    }
    enum Labels {
        static let titlesFont: UIFont = .systemFont(ofSize: 15, weight: .bold)
        static let titleColor: UIColor = .black
    }
}
