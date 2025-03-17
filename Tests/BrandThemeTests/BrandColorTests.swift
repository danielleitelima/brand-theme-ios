import XCTest
@testable import BrandTheme

final class BrandColorTests: XCTestCase {
    
    func testAllBrandColorsExistInAssets() {
        for colorCase in BrandColor.allCases {
            let color = colorCase.load()
            XCTAssertNotNil(color, "Color '\(colorCase.rawValue)' not found in ColorScheme.xcassets")
        }
    }
} 