import UIKit

public extension UIFont {
    static var displayLarge: UIFont { brandFont(.displayLarge) }
    static var displayMedium: UIFont { brandFont(.displayMedium) }
    static var displaySmall: UIFont { brandFont(.displaySmall) }
    static var headlineLarge: UIFont { brandFont(.headlineLarge) }
    static var headlineMedium: UIFont { brandFont(.headlineMedium) }
    static var headlineSmall: UIFont { brandFont(.headlineSmall) }
    static var titleLarge: UIFont { brandFont(.titleLarge) }
    static var titleMedium: UIFont { brandFont(.titleMedium) }
    static var titleSmall: UIFont { brandFont(.titleSmall) }
    static var labelLarge: UIFont { brandFont(.labelLarge) }
    static var labelMedium: UIFont { brandFont(.labelMedium) }
    static var labelSmall: UIFont { brandFont(.labelSmall) }
    static var bodyLarge: UIFont { brandFont(.bodyLarge) }
    static var bodyMedium: UIFont { brandFont(.bodyMedium) }
    static var bodySmall: UIFont { brandFont(.bodySmall) }
}

public extension UIFont {
    static func displayLarge(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.displayLarge, for: traitCollection)
    }
    
    static func displayMedium(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.displayMedium, for: traitCollection)
    }
    
    static func displaySmall(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.displaySmall, for: traitCollection)
    }
    
    static func headlineLarge(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.headlineLarge, for: traitCollection)
    }
    
    static func headlineMedium(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.headlineMedium, for: traitCollection)
    }
    
    static func headlineSmall(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.headlineSmall, for: traitCollection)
    }
    
    static func titleLarge(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.titleLarge, for: traitCollection)
    }
    
    static func titleMedium(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.titleMedium, for: traitCollection)
    }
    
    static func titleSmall(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.titleSmall, for: traitCollection)
    }
    
    static func labelLarge(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.labelLarge, for: traitCollection)
    }
    
    static func labelMedium(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.labelMedium, for: traitCollection)
    }
    
    static func labelSmall(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.labelSmall, for: traitCollection)
    }
    
    static func bodyLarge(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.bodyLarge, for: traitCollection)
    }
    
    static func bodyMedium(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.bodyMedium, for: traitCollection)
    }
    
    static func bodySmall(for traitCollection: UITraitCollection) -> UIFont {
        brandFont(.bodySmall, for: traitCollection)
    }
}

extension UIFont {
    static func brandFont(_ typography: BrandTypography) -> UIFont {
        return BrandTheme().getTypography(typography, contentSize: .unspecified)
    }
    
    static func brandFont(_ typography: BrandTypography, for traitCollection: UITraitCollection) -> UIFont {
        return BrandTheme().getTypography(typography, contentSize: traitCollection.preferredContentSizeCategory)
    }
}

extension UIFont {
    private static func registerFont(
        withName name: String,
        extension fileExtension: String,
        in bundle: Bundle
    ) -> Bool {
        guard let pathForResourceString = bundle.path(forResource: name, ofType: fileExtension),
              let fontData = NSData(contentsOfFile: pathForResourceString),
              let dataProvider = CGDataProvider(data: fontData),
              let fontRef = CGFont(dataProvider) else {
            print("Error loading font \(name).\(fileExtension)")
            return false
        }
        
        var errorRef: Unmanaged<CFError>? = nil
        if CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false {
            if let error = errorRef?.takeRetainedValue() {
                let errorDescription = CFErrorCopyDescription(error)
                print("Error registering font: \(errorDescription)")
            } else {
                print("Error registering font \(name).\(fileExtension)")
            }
            return false
        }
        
        return true
    }
    
    static func loadAll() {
        let fontBundle = Bundle(for: BrandTheme.self)
        
        let dispatchGroup = DispatchGroup()
        
        FontAsset.allCases.forEach { (asset) in
            dispatchGroup.enter()
            DispatchQueue.global(qos: .userInitiated).async {
                let success = registerFont(
                    withName: asset.rawValue,
                    extension: asset.fileExtension,
                    in: fontBundle
                )
                if !success {
                    print("Warning: Failed to register font \(asset.rawValue).\(asset.fileExtension)")
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            NotificationCenter.default.post(name: .init("BrandThemeFontsLoaded"), object: nil)
        }
    }
}
