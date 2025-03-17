import UIKit

public enum BrandColor: String, CaseIterable {
    case primary
    case surfaceTint
    case onPrimary
    case primaryContainer
    case onPrimaryContainer
    case secondary
    case onSecondary
    case secondaryContainer
    case onSecondaryContainer
    case tertiary
    case onTertiary
    case tertiaryContainer
    case onTertiaryContainer
    case error
    case onError
    case errorContainer
    case onErrorContainer
    case background
    case onBackground
    case surface
    case onSurface
    case surfaceVariant
    case onSurfaceVariant
    case outline
    case outlineVariant
    case shadow
    case scrim
    case surfaceContainerLowest
    case surfaceContainerLow
    case surfaceContainer
    case surfaceContainerHigh
    case surfaceContainerHighest
}

extension BrandColor {
    private var bundle: Bundle {
        return Bundle.module
    }
    
    public func load() -> UIColor? {
        return UIColor(
            named: self.rawValue,
            in: bundle,
            compatibleWith: .current
        )
    }
    
    public static func color(_ brandColor: BrandColor) -> UIColor {
        return brandColor.load()!
    }
}
