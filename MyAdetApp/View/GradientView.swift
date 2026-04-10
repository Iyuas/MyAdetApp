//
//  GradientView.swift
//  MyAdetApp
//
//  Created by Дастан Жалгас on 09.12.2025.
//

import UIKit

class GradientView: UIView {

    private let gradientLayer = CAGradientLayer()

    var colors: [UIColor] = AppConstants.Colors.primaryGradient {
        didSet {
            updateGradient()
        }
    }

    var startPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            gradientLayer.startPoint = startPoint
        }
    }

    var endPoint: CGPoint = CGPoint(x: 1, y: 1) {
        didSet {
            gradientLayer.endPoint = endPoint
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }

    private func setupGradient() {
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
        updateGradient()
    }

    private func updateGradient() {
        gradientLayer.colors = colors.map { $0.cgColor }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
