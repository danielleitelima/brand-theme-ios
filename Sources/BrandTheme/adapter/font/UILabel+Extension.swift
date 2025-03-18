import UIKit
import BrandTheme

extension UILabel {
    func setTypography(_ typography: BrandTypography) {
        self.font = BrandTheme().getTypography(typography, contentSize: self.traitCollection.preferredContentSizeCategory)
    }
} 
