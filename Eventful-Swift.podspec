
Pod::Spec.new do |s|

  s.name         = "Eventful-Swift"
  s.version      = "1.0.0"
  s.summary      = "Simple, lightweight, and useful event library for Swift."
  s.description  = <<-DESC
    Eventful-Swift is a Swift library for lightweight event dispatching & handling.
    By conforming to the EventDispatcher protocol, a class or struct can define various
    events (via Event<T> or EventRef<T>) that can be listened for and reacted upon.
    This library is a work in progress.
    DESC
  s.homepage     = "https://github.com/mitchtreece/Eventful-Swift"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Mitch Treece" => "mitchtreece@me.com" }
  s.social_media_url   = "http://twitter.com/MitchTreece"

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/mitchtreece/Eventful-Swift.git", :tag => "1.0.0" }
  s.source_files  = "Eventful-Swift/Eventful-Swift/*.swift"
  # s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Classes/**/*.h"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
