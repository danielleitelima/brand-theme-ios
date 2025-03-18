import UIKit
import BrandTheme

public extension UILabel {
    func setTypography(_ typography: BrandTypography) {
        self.font = BrandTheme().getTypography(typography, contentSize: self.traitCollection.preferredContentSizeCategory)
    }
} 
