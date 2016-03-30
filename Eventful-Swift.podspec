
Pod::Spec.new do |s|

  s.name         = "Eventful-Swift"
  s.module_name  = "EventfulSwift"
  s.version      = "1.0.2"
  s.summary      = "Simple, lightweight, and useful event library for Swift."
  s.description  = <<-DESC
    Eventful-Swift is a Swift library for lightweight event dispatching & handling.
    By conforming to the EventDispatcher protocol, a class or struct can define various
    events (via Event<T> or EventRef<T>) that can be listened for and reacted upon.
    DESC
  s.homepage           = "https://github.com/mitchtreece/Eventful-Swift"
  s.license            = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Mitch Treece" => "mitchtreece@me.com" }
  s.social_media_url   = "http://twitter.com/MitchTreece"

  s.platform      = :ios, "8.0"
  s.source        = { :git => "https://github.com/mitchtreece/Eventful-Swift.git", :tag => "#{s.version}" }
  s.source_files  = "Eventful-Swift/*.{swift}"

end
