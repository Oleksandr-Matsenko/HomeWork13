//
//  UIBuilder.swift
//  Lesson13HW
//
//  Created by Alex Matsenko on 16.04.2024.
//

import UIKit
struct UIBuilder {
    static func createLabel(font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
