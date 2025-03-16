# BrandThemeKit

A Swift package containing shared utilities for iOS applications.

## Features

- Remote image loading with placeholder support

## Requirements

- iOS 13.0+
- Swift 5.5+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/brand-theme-ios.git", from: "1.0.0")
]
```

Or add it directly in Xcode:
1. File > Swift Packages > Add Package Dependency
2. Enter the repository URL: `https://github.com/yourusername/brand-theme-ios.git`
3. Specify the version requirements

## Usage

### Image Loading

```swift
import BrandThemeKit
import UIKit

// Example usage
let imageURL = URL(string: "https://example.com/image.jpg")!
let placeholder = UIImage(named: "placeholder")!

let task = getRemoteImage(url: imageURL, placeholder: placeholder) { image in
    // Use the loaded image
    self.imageView.image = image
}

// Start the download
task.resume()
```

## License

This package is available under the MIT license. See the LICENSE file for more info. 