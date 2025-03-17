import UIKit

struct ScaledTypography {
    private enum FontType {
        case regular
        case medium
        
        var asset: FontAsset {
            switch self {
            case .regular:
                return .robotoRegular
            case .medium:
                return .robotoMedium
            }
        }
    }
    
    static func load(
        _ typography: BrandTypography,
        contentSize: UIContentSizeCategory
    ) -> UIFont {
        switch typography {
        case .displayLarge:
            return createFont(size: 57, type: .regular, contentSize: contentSize)
        case .displayMedium:
            return createFont(size: 45, type: .regular, contentSize: contentSize)
        case .displaySmall:
            return createFont(size: 36, type: .regular, contentSize: contentSize)
        case .headlineLarge:
            return createFont(size: 32, type: .regular, contentSize: contentSize)
        case .headlineMedium:
            return createFont(size: 28, type: .regular, contentSize: contentSize)
        case .headlineSmall:
            return createFont(size: 24, type: .regular, contentSize: contentSize)
        case .titleLarge:
            return createFont(size: 22, type: .regular, contentSize: contentSize)
        case .titleMedium:
            return createFont(size: 16, type: .medium, contentSize: contentSize)
        case .titleSmall:
            return createFont(size: 14, type: .medium, contentSize: contentSize)
        case .labelLarge:
            return createFont(size: 14, type: .medium, contentSize: contentSize)
        case .labelMedium:
            return createFont(size: 12, type: .medium, contentSize: contentSize)
        case .labelSmall:
            return createFont(size: 11, type: .medium, contentSize: contentSize)
        case .bodyLarge:
            return createFont(size: 16, type: .regular, contentSize: contentSize)
        case .bodyMedium:
            return createFont(size: 14, type: .regular, contentSize: contentSize)
        case .bodySmall:
            return createFont(size: 12, type: .regular, contentSize: contentSize)
        }
    }

    private static func createFont(
        size defaultSize: CGFloat,
        type: FontType,
        contentSize: UIContentSizeCategory
    ) -> UIFont {
        let scaledSize = getSize(defaultSize: defaultSize, contentSize: contentSize)
        return type.asset.load(size: scaledSize)!
    }

    private static func getSize(
        defaultSize: CGFloat,
        contentSize: UIContentSizeCategory
    ) -> CGFloat {
        let size: CGFloat
        switch contentSize {
        case .extraSmall:
            size = defaultSize - 3
        case .small:
            size = defaultSize - 2
        case .medium:
            size = defaultSize - 1
        case .large:
            size = defaultSize
        case .extraLarge:
            size = defaultSize + 1
        case .extraExtraLarge:
            size = defaultSize + 2
        case .extraExtraExtraLarge:
            size = defaultSize + 3
        case .accessibilityMedium:
            size = defaultSize + 7
        case .accessibilityLarge:
            size = defaultSize + 11
        case .accessibilityExtraLarge:
            size = defaultSize + 15
        case .accessibilityExtraExtraLarge:
            size = defaultSize + 19
        case .accessibilityExtraExtraExtraLarge:
            size = defaultSize + 23
        case .unspecified:
            size = defaultSize
        default:
            size = defaultSize
        }

        return size
    }
}
