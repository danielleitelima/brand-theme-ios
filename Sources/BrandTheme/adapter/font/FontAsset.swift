import UIKit

enum FontAsset: String, CaseIterable {

    case robotoThin = "Roboto-Thin"
    case robotoThinItalic = "Roboto-ThinItalic"
    case robotoExtraLight = "Roboto-ExtraLight"
    case robotoExtraLightItalic = "Roboto-ExtraLightItalic"
    case robotoLight = "Roboto-Light"
    case robotoLightItalic = "Roboto-LightItalic"
    case robotoRegular = "Roboto-Regular"
    case robotoItalic = "Roboto-Italic"
    case robotoMedium = "Roboto-Medium"
    case robotoMediumItalic = "Roboto-MediumItalic"
    case robotoSemiBold = "Roboto-SemiBold"
    case robotoSemiBoldItalic = "Roboto-SemiBoldItalic"
    case robotoBold = "Roboto-Bold"
    case robotoBoldItalic = "Roboto-BoldItalic"
    case robotoExtraBold = "Roboto-ExtraBold"
    case robotoExtraBoldItalic = "Roboto-ExtraBoldItalic"
    case robotoBlack = "Roboto-Black"
    case robotoBlackItalic = "Roboto-BlackItalic"

    var fileExtension: String {
        switch self {
        case 
            .robotoThin,
            .robotoThinItalic,
            .robotoExtraLight,
            .robotoExtraLightItalic,
            .robotoLight,
            .robotoLightItalic,
            .robotoRegular,
            .robotoItalic,
            .robotoMedium,
            .robotoMediumItalic,
            .robotoSemiBold,
            .robotoSemiBoldItalic,
            .robotoBold,
            .robotoBoldItalic,
            .robotoExtraBold,
            .robotoExtraBoldItalic,
            .robotoBlack,
            .robotoBlackItalic:
            return "ttf"
        }
    }
    
    func load(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: self.rawValue, size: size) {
            return customFont
        }
        print("Warning: Unable to load font \(rawValue). Using system fallback.")
        
        switch self {
        case .robotoBold, .robotoBoldItalic, .robotoBlack, .robotoBlackItalic, .robotoExtraBold, .robotoExtraBoldItalic:
            return UIFont.systemFont(ofSize: size, weight: .bold)
        case .robotoMedium, .robotoMediumItalic, .robotoSemiBold, .robotoSemiBoldItalic:
            return UIFont.systemFont(ofSize: size, weight: .medium)
        case .robotoLight, .robotoLightItalic, .robotoThin, .robotoThinItalic:
            return UIFont.systemFont(ofSize: size, weight: .light)
        case .robotoItalic, .robotoThinItalic, .robotoLightItalic, .robotoMediumItalic, 
             .robotoSemiBoldItalic, .robotoBoldItalic, .robotoExtraBoldItalic, .robotoBlackItalic:
            return UIFont.italicSystemFont(ofSize: size)
        default:
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
    }
}
