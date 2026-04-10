//
//  ProgressRingView.swift
//  MyAdetApp
//
//  Created by Дастан Жалгас on 09.12.2025.
//

import UIKit

class ProgressRingView: UIView {
    
    private let backgroundLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let centerLabel = UILabel()

    var progress: CGFloat = 0 {
        didSet {
            updateProgress(animated: true)
        }
    }

    var lineWidth: CGFloat = 8 {
        didSet {
            backgroundLayer.lineWidth = lineWidth
            progressLayer.lineWidth = lineWidth
        }
    }

    var progressColor: UIColor = AppConstants.Colors.accent {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }

    var trackColor: UIColor = UIColor.systemGray5 {
        didSet {
            backgroundLayer.strokeColor = trackColor.cgColor
        }
    }

    var showsPercentage: Bool = true {
        didSet {
            centerLabel.isHidden = !showsPercentage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        setupLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
        setupLabel()
    }

    private func setupLayers() {
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = trackColor.cgColor
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.lineCap = .round
        layer.addSublayer(backgroundLayer)

        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }

    private func setupLabel() {
        centerLabel.textAlignment = .center
        centerLabel.font = AppConstants.Typography.headline
        centerLabel.textColor = AppConstants.Colors.primaryText
        addSubview(centerLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2

        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -.pi / 2,
            endAngle: 3 * .pi / 2,
            clockwise: true
        )

        backgroundLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath

        centerLabel.frame = bounds
    }

    private func updateProgress(animated: Bool) {
        let clampedProgress = min(max(progress, 0), 1)

        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = progressLayer.strokeEnd
            animation.toValue = clampedProgress
            animation.duration = 0.5
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            progressLayer.add(animation, forKey: "progressAnimation")
        }

        progressLayer.strokeEnd = clampedProgress

        if showsPercentage {
            let percentage = Int(clampedProgress * 100)
            centerLabel.text = "\(percentage)%"
        }
    }
    
    func setProgress(_ value: CGFloat, animated: Bool = true) {
        progress = value
    }
}
