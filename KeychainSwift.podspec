Pod::Spec.new do |s|
  s.name        = "KeychainSwift"
  s.version     = "6.0.2"
  s.license     = { :type => "MIT" }
  s.homepage    = "https://github.com/marketplacer/keychain-swift"
  s.summary     = "A library for saving text and data in the Keychain with Swift."
  s.description = <<-DESC
                This is a collection of helper functions for saving text and data in the Keychain.

                * Write and read text and Data with simple functions.
                * Specify optional access rule for the keychain item.
                * Limit operations to a specific access group.
                DESC
  s.authors     = { "Evgenii Neumerzhitckii" => "sausageskin@gmail.com" }
  s.source      = { :git => "https://github.com/marketplacer/keychain-swift.git", :tag => s.version }
  s.screenshots  = "https://raw.githubusercontent.com/marketplacer/keychain-swift/master/graphics/keychain-swift-demo-3.png"
  s.source_files = "KeychainSwift/*.swift"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.xcconfig    = { 'SWIFT_VERSION' => '3.0' }
end