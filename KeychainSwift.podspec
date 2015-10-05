Pod::Spec.new do |s|
  s.name        = "KeychainSwift"
  s.version     = "3.0.1"
  s.license     = { :type => "MIT" }
  s.homepage    = "https://github.com/exchangegroup/keychain-swift"
  s.summary     = "A library for saving text and data in the Keychain with Swift."
  s.description = <<-DESC
                This is a collection of helper functions for saving text and data in the Keychain.

                * Write and read text and NSData with simple functions.
                * Specify optional access rule for the keychain item.
                DESC
  s.authors     = { "Evgenii Neumerzhitckii" => "sausageskin@gmail.com" }
  s.source      = { :git => "https://github.com/exchangegroup/keychain-swift.git", :tag => s.version }
  s.screenshots  = "https://raw.githubusercontent.com/exchangegroup/keychain-swift/master/graphics/keychain-swift-demo.png"
  s.source_files = "KeychainSwift/*.swift"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
end