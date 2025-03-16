import UIKit

public enum BrandColor: String, CaseIterable {
    case backgroundPrimary
    case textPrimary
    case textSecondary
    case textPlaceholder
    case actionPrimary
    case backgroundSecondary
}

extension BrandColor {
    private var bundle: Bundle {
        return Bundle.module
    }
    
    public func load() -> UIColor {
        guard let color = UIColor(
            named: self.rawValue,
            in: bundle,
            compatibleWith: .current
        ) else {
            print("Warning: Color '\(self.rawValue)' not found in bundle")
            return .black
        }
        return color
    }
    
    public static func color(_ brandColor: BrandColor) -> UIColor {
        return brandColor.load()
    }
}
