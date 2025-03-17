#!/usr/bin/env swift

import Foundation

private let scriptDirectory: String = {
    let arguments = CommandLine.arguments
    let scriptPath = arguments[0]
    return URL(fileURLWithPath: scriptPath).deletingLastPathComponent().path
}()

private let colorSchemes = """
{
  "schemes": {
    "light": {
      "primary": "#146683",
      "surfaceTint": "#146683",
      "onPrimary": "#FFFFFF",
      "primaryContainer": "#BFE9FF",
      "onPrimaryContainer": "#001F2A",
      "secondary": "#4D616C",
      "onSecondary": "#FFFFFF",
      "secondaryContainer": "#D0E6F3",
      "onSecondaryContainer": "#081E27",
      "tertiary": "#5E5A7D",
      "onTertiary": "#FFFFFF",
      "tertiaryContainer": "#E4DFFF",
      "onTertiaryContainer": "#1A1836",
      "error": "#BA1A1A",
      "onError": "#FFFFFF",
      "errorContainer": "#FFDAD6",
      "onErrorContainer": "#410002",
      "background": "#F6FAFE",
      "onBackground": "#171C1F",
      "surface": "#F6FAFE",
      "onSurface": "#171C1F",
      "surfaceVariant": "#DCE3E9",
      "onSurfaceVariant": "#40484C",
      "outline": "#70787D",
      "outlineVariant": "#C0C8CD",
      "shadow": "#000000",
      "scrim": "#000000",
      "surfaceContainerLowest": "#FFFFFF",
      "surfaceContainerLow": "#F0F4F8",
      "surfaceContainer": "#EAEEF2",
      "surfaceContainerHigh": "#E4E9EC",
      "surfaceContainerHighest": "#DFE3E7"
    },
    "light-high-contrast": {
      "primary": "#002633",
      "surfaceTint": "#146683",
      "onPrimary": "#FFFFFF",
      "primaryContainer": "#004960",
      "onPrimaryContainer": "#FFFFFF",
      "secondary": "#10252E",
      "onSecondary": "#FFFFFF",
      "secondaryContainer": "#324650",
      "onSecondaryContainer": "#FFFFFF",
      "tertiary": "#211E3D",
      "onTertiary": "#FFFFFF",
      "tertiaryContainer": "#423F60",
      "onTertiaryContainer": "#FFFFFF",
      "error": "#4E0002",
      "onError": "#FFFFFF",
      "errorContainer": "#8C0009",
      "onErrorContainer": "#FFFFFF",
      "background": "#F6FAFE",
      "onBackground": "#171C1F",
      "surface": "#F6FAFE",
      "onSurface": "#000000",
      "surfaceVariant": "#DCE3E9",
      "onSurfaceVariant": "#1E2529",
      "outline": "#3C4448",
      "outlineVariant": "#3C4448",
      "shadow": "#000000",
      "scrim": "#000000",
      "surfaceContainerLowest": "#FFFFFF",
      "surfaceContainerLow": "#F0F4F8",
      "surfaceContainer": "#EAEEF2",
      "surfaceContainerHigh": "#E4E9EC",
      "surfaceContainerHighest": "#DFE3E7"
    },
    "dark": {
      "primary": "#8CCFF0",
      "surfaceTint": "#8CCFF0",
      "onPrimary": "#003547",
      "primaryContainer": "#004D65",
      "onPrimaryContainer": "#BFE9FF",
      "secondary": "#B4CAD6",
      "onSecondary": "#1F333D",
      "secondaryContainer": "#364954",
      "onSecondaryContainer": "#D0E6F3",
      "tertiary": "#C7C2EA",
      "onTertiary": "#2F2D4C",
      "tertiaryContainer": "#464364",
      "onTertiaryContainer": "#E4DFFF",
      "error": "#FFB4AB",
      "onError": "#690005",
      "errorContainer": "#93000A",
      "onErrorContainer": "#FFDAD6",
      "background": "#0F1417",
      "onBackground": "#DFE3E7",
      "surface": "#0F1417",
      "onSurface": "#DFE3E7",
      "surfaceVariant": "#40484C",
      "onSurfaceVariant": "#C0C8CD",
      "outline": "#8A9297",
      "outlineVariant": "#40484C",
      "shadow": "#000000",
      "scrim": "#000000",
      "surfaceContainerLowest": "#0A0F12",
      "surfaceContainerLow": "#171C1F",
      "surfaceContainer": "#1B2023",
      "surfaceContainerHigh": "#262B2E",
      "surfaceContainerHighest": "#303538"
    },
    "dark-high-contrast": {
      "primary": "#F7FBFF",
      "surfaceTint": "#8CCFF0",
      "onPrimary": "#000000",
      "primaryContainer": "#90D4F5",
      "onPrimaryContainer": "#000000",
      "secondary": "#F7FBFF",
      "onSecondary": "#000000",
      "secondaryContainer": "#B8CEDA",
      "onSecondaryContainer": "#000000",
      "tertiary": "#FEF9FF",
      "onTertiary": "#000000",
      "tertiaryContainer": "#CBC6EF",
      "onTertiaryContainer": "#000000",
      "error": "#FFF9F9",
      "onError": "#000000",
      "errorContainer": "#FFBAB1",
      "onErrorContainer": "#000000",
      "background": "#0F1417",
      "onBackground": "#DFE3E7",
      "surface": "#0F1417",
      "onSurface": "#FFFFFF",
      "surfaceVariant": "#40484C",
      "onSurfaceVariant": "#F7FBFF",
      "outline": "#C4CCD1",
      "outlineVariant": "#C4CCD1",
      "shadow": "#000000",
      "scrim": "#000000",
      "surfaceContainerLowest": "#0A0F12",
      "surfaceContainerLow": "#171C1F",
      "surfaceContainer": "#1B2023",
      "surfaceContainerHigh": "#262B2E",
      "surfaceContainerHighest": "#303538"
    }
  }
}
"""

private func hexToRGB(_ hex: String) -> (red: String, green: String, blue: String) {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt64 = 0
    Scanner(string: hexSanitized).scanHexInt64(&rgb)
    
    let red = String(format: "0x%02X", (rgb & 0xFF0000) >> 16)
    let green = String(format: "0x%02X", (rgb & 0x00FF00) >> 8)
    let blue = String(format: "0x%02X", rgb & 0x0000FF)
    
    return (red, green, blue)
}

private func createColorContentsJson(colorName: String, lightHex: String, darkHex: String, highContrastLightHex: String, highContrastDarkHex: String) -> String {
    let lightRgb = hexToRGB(lightHex)
    let darkRgb = hexToRGB(darkHex)
    let highContrastLightRgb = hexToRGB(highContrastLightHex)
    let highContrastDarkRgb = hexToRGB(highContrastDarkHex)
    
    return """
{
  "colors" : [
    {
      "color" : {
        "color-space" : "srgb",
        "components" : {
          "alpha" : "1.000",
          "blue" : "\(lightRgb.blue)",
          "green" : "\(lightRgb.green)",
          "red" : "\(lightRgb.red)"
        }
      },
      "idiom" : "universal"
    },
    {
      "appearances" : [
        {
          "appearance" : "luminosity",
          "value" : "dark"
        }
      ],
      "color" : {
        "color-space" : "srgb",
        "components" : {
          "alpha" : "1.000",
          "blue" : "\(darkRgb.blue)",
          "green" : "\(darkRgb.green)",
          "red" : "\(darkRgb.red)"
        }
      },
      "idiom" : "universal"
    },
    {
      "appearances" : [
        {
          "appearance" : "contrast",
          "value" : "high"
        }
      ],
      "color" : {
        "color-space" : "srgb",
        "components" : {
          "alpha" : "1.000",
          "blue" : "\(highContrastLightRgb.blue)",
          "green" : "\(highContrastLightRgb.green)",
          "red" : "\(highContrastLightRgb.red)"
        }
      },
      "idiom" : "universal"
    },
    {
      "appearances" : [
        {
          "appearance" : "luminosity",
          "value" : "dark"
        },
        {
          "appearance" : "contrast",
          "value" : "high"
        }
      ],
      "color" : {
        "color-space" : "srgb",
        "components" : {
          "alpha" : "1.000",
          "blue" : "\(highContrastDarkRgb.blue)",
          "green" : "\(highContrastDarkRgb.green)",
          "red" : "\(highContrastDarkRgb.red)"
        }
      },
      "idiom" : "universal"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
"""
}

private guard let jsonData = colorSchemes.data(using: .utf8),
      let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
      let schemes = json["schemes"] as? [String: [String: String]] else {
    print("Error parsing JSON")
    exit(1)
}

private let light = schemes["light"]!
private let lightHighContrast = schemes["light-high-contrast"]!
private let dark = schemes["dark"]!
private let darkHighContrast = schemes["dark-high-contrast"]!

private let allColors = [
    "primary",
    "surfaceTint",
    "onPrimary",
    "primaryContainer",
    "onPrimaryContainer",
    "secondary",
    "onSecondary",
    "secondaryContainer",
    "onSecondaryContainer",
    "tertiary",
    "onTertiary",
    "tertiaryContainer",
    "onTertiaryContainer",
    "error",
    "onError",
    "errorContainer",
    "onErrorContainer",
    "background",
    "onBackground",
    "surface",
    "onSurface",
    "surfaceVariant",
    "onSurfaceVariant",
    "outline",
    "outlineVariant",
    "shadow",
    "scrim",
    "surfaceContainerLowest",
    "surfaceContainerLow",
    "surfaceContainer",
    "surfaceContainerHigh",
    "surfaceContainerHighest"
]

for colorName in allColors {
    guard let lightHex = light[colorName],
          let darkHex = dark[colorName],
          let highContrastLightHex = lightHighContrast[colorName],
          let highContrastDarkHex = darkHighContrast[colorName] else {
        print("Missing color value for \(colorName)")
        continue
    }
    
    let contentsJson = createColorContentsJson(
        colorName: colorName,
        lightHex: lightHex,
        darkHex: darkHex,
        highContrastLightHex: highContrastLightHex,
        highContrastDarkHex: highContrastDarkHex
    )
    
    let assetsDirectory = URL(fileURLWithPath: scriptDirectory)
        .deletingLastPathComponent() // adapter
        .deletingLastPathComponent() // BrandTheme
        .deletingLastPathComponent() // Sources
        .appendingPathComponent("ColorScheme.xcassets").path
    
    let colorsetDirectory = "\(assetsDirectory)/\(colorName).colorset"
    
    let process1 = Process()
    process1.executableURL = URL(fileURLWithPath: "/bin/mkdir")
    process1.arguments = ["-p", colorsetDirectory]
    try process1.run()
    process1.waitUntilExit()
    
    let contentsJsonPath = "\(colorsetDirectory)/Contents.json"
    let fileManager = FileManager.default
    fileManager.createFile(atPath: contentsJsonPath, contents: contentsJson.data(using: .utf8))
    
    print("Created \(colorName).colorset at \(colorsetDirectory)")
}

print("All color assets created successfully!") 