import UIKit

let bundle = Bundle(for: BrandTheme.self)

public protocol ThemeProvider {
    func getColor(_ color: BrandColor) -> UIColor
    func getTypography(_ typography: BrandTypography, contentSize: UIContentSizeCategory) -> UIFont
}

public class BrandTheme: ThemeProvider {

    public init() {
        UIFont.loadAll()
    }
    
    public func getColor(_ color: BrandColor) -> UIColor {
        return color.load()!
    }

    public func getTypography(
        _ typography: BrandTypography,
        contentSize: UIContentSizeCategory
    ) -> UIFont {
        return ScaledTypography.load(
            typography,
            contentSize: contentSize
        )
    }
}
