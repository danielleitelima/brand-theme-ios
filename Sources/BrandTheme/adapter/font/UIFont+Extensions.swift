import UIKit

extension UIFont {
    private var bundle: Bundle {
        return Bundle.module
    }

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
        
        let dispatchGroup = DispatchGroup()
        
        FontAsset.allCases.forEach { (asset) in
            dispatchGroup.enter()
            DispatchQueue.global(qos: .userInitiated).async {
                let success = registerFont(
                    withName: asset.rawValue,
                    extension: asset.fileExtension,
                    in: bundle
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
