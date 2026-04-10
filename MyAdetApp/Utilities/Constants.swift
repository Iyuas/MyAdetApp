//
//  Constants.swift
//  MyAdetApp
//
//  Created by Дастан Жалгас
//

import UIKit

struct AppConstants {

    struct API {
        static let quotesBaseURL = "https://api.quotable.io"
        static let randomQuoteEndpoint = "/random"
    }

    struct Colors {
        static let primaryGradient = [
            UIColor(red: 0.51, green: 0.27, blue: 0.95, alpha: 1.0),  // Purple
            UIColor(red: 0.91, green: 0.30, blue: 0.64, alpha: 1.0),  // Pink
        ]

        static let secondaryGradient = [
            UIColor(red: 0.20, green: 0.73, blue: 0.89, alpha: 1.0),  // Teal
            UIColor(red: 0.35, green: 0.49, blue: 0.98, alpha: 1.0),  // Blue
        ]

        static let successGradient = [
            UIColor(red: 0.20, green: 0.84, blue: 0.53, alpha: 1.0),  // Green
            UIColor(red: 0.13, green: 0.69, blue: 0.45, alpha: 1.0),  // Dark Green
        ]

        static let warningGradient = [
            UIColor(red: 1.00, green: 0.73, blue: 0.26, alpha: 1.0),  // Orange
            UIColor(red: 1.00, green: 0.45, blue: 0.26, alpha: 1.0),  // Red Orange
        ]

        static let cardBackground = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(white: 0.15, alpha: 1.0)
                : UIColor.white
        }

        static let primaryText = UIColor.label
        static let secondaryText = UIColor.secondaryLabel
        static let accent = UIColor(red: 0.51, green: 0.27, blue: 0.95, alpha: 1.0)
    }

    struct Spacing {
        static let xs: CGFloat = 4
        static let s: CGFloat = 8
        static let m: CGFloat = 16
        static let l: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }

    
    struct Typography {
        static let largeTitle = UIFont.systemFont(ofSize: 34, weight: .bold)
        static let title = UIFont.systemFont(ofSize: 28, weight: .bold)
        static let headline = UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let body = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let callout = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let caption = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let footnote = UIFont.systemFont(ofSize: 12, weight: .regular)
    }

    struct Animation {
        static let defaultDuration: TimeInterval = 0.3
        static let springDamping: CGFloat = 0.7
        static let springVelocity: CGFloat = 0.5
    }

    struct Layout {
        static let cornerRadius: CGFloat = 16
        static let smallCornerRadius: CGFloat = 12
        static let cardShadowRadius: CGFloat = 8
        static let cardShadowOpacity: Float = 0.1
    }
}
