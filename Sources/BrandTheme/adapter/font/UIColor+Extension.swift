import UIKit
import BrandTheme

extension UIColor {
    static func brandColor(_ color: BrandColor) -> UIColor {
        return BrandColor.color(color)
    }
}

extension UIColor {
    static var primary: UIColor { brandColor(.primary) }
    static var onPrimary: UIColor { brandColor(.onPrimary) }
    static var primaryContainer: UIColor { brandColor(.primaryContainer) }
    static var onPrimaryContainer: UIColor { brandColor(.onPrimaryContainer) }
    
    static var secondary: UIColor { brandColor(.secondary) }
    static var onSecondary: UIColor { brandColor(.onSecondary) }
    static var secondaryContainer: UIColor { brandColor(.secondaryContainer) }
    static var onSecondaryContainer: UIColor { brandColor(.onSecondaryContainer) }
    
    static var tertiary: UIColor { brandColor(.tertiary) }
    static var onTertiary: UIColor { brandColor(.onTertiary) }
    static var tertiaryContainer: UIColor { brandColor(.tertiaryContainer) }
    static var onTertiaryContainer: UIColor { brandColor(.onTertiaryContainer) }
    
    static var error: UIColor { brandColor(.error) }
    static var onError: UIColor { brandColor(.onError) }
    static var errorContainer: UIColor { brandColor(.errorContainer) }
    static var onErrorContainer: UIColor { brandColor(.onErrorContainer) }
    
    static var surface: UIColor { brandColor(.surface) }
    static var onSurface: UIColor { brandColor(.onSurface) }
    static var surfaceVariant: UIColor { brandColor(.surfaceVariant) }
    static var onSurfaceVariant: UIColor { brandColor(.onSurfaceVariant) }
    static var surfaceTint: UIColor { brandColor(.surfaceTint) }
    
    static var surfaceContainerLowest: UIColor { brandColor(.surfaceContainerLowest) }
    static var surfaceContainerLow: UIColor { brandColor(.surfaceContainerLow) }
    static var surfaceContainer: UIColor { brandColor(.surfaceContainer) }
    static var surfaceContainerHigh: UIColor { brandColor(.surfaceContainerHigh) }
    static var surfaceContainerHighest: UIColor { brandColor(.surfaceContainerHighest) }
    
    static var background: UIColor { brandColor(.background) }
    static var onBackground: UIColor { brandColor(.onBackground) }
    
    static var outline: UIColor { brandColor(.outline) }
    static var outlineVariant: UIColor { brandColor(.outlineVariant) }
    static var shadow: UIColor { brandColor(.shadow) }
    static var scrim: UIColor { brandColor(.scrim) }
} 
