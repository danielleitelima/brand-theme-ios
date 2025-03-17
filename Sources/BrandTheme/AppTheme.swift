import UIKit

let bundle = Bundle(for: BrandTheme.self)

public protocol ThemeProvider {
    func getColor(_ color: BrandColor) -> UIColor
}

public class BrandTheme: ThemeProvider {
    
    public func getColor(_ color: BrandColor) -> UIColor {
        return color.load()!
    }
}
