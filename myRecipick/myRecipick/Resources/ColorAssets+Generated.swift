// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Colors {
  internal static let backgroundBlue = ColorAsset(name: "BackgroundBlue")
  internal static let backgroundBrown = ColorAsset(name: "BackgroundBrown")
  internal static let backgroundOrange = ColorAsset(name: "BackgroundOrange")
  internal static let backgroundPink = ColorAsset(name: "BackgroundPink")
  internal static let black = ColorAsset(name: "Black")
  internal static let dimmed = ColorAsset(name: "Dimmed")
  internal static let error = ColorAsset(name: "Error")
  internal static let grayScale33 = ColorAsset(name: "GrayScale33")
  internal static let grayScale66 = ColorAsset(name: "GrayScale66")
  internal static let grayScale99 = ColorAsset(name: "GrayScale99")
  internal static let grayScaleBD = ColorAsset(name: "GrayScaleBD")
  internal static let grayScaleEE = ColorAsset(name: "GrayScaleEE")
  internal static let grayScaleF7 = ColorAsset(name: "GrayScaleF7")
  internal static let homeBottomColor = ColorAsset(name: "HomeBottomColor")
  internal static let imagePlaceHolder = ColorAsset(name: "ImagePlaceHolder")
  internal static let navigationTitle = ColorAsset(name: "NavigationTitle")
  internal static let positive = ColorAsset(name: "Positive")
  internal static let primaryDark = ColorAsset(name: "PrimaryDark")
  internal static let primaryLight = ColorAsset(name: "PrimaryLight")
  internal static let primaryLight2 = ColorAsset(name: "PrimaryLight2")
  internal static let primaryNormal = ColorAsset(name: "PrimaryNormal")
  internal static let sampleColor = ColorAsset(name: "SampleColor")
  internal static let scrimBlack = ColorAsset(name: "ScrimBlack")
  internal static let secondaryGreen = ColorAsset(name: "SecondaryGreen")
  internal static let white = ColorAsset(name: "White")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
