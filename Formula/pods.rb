class Pods < Formula
  desc "🌱 Cozy pod install"
  homepage "https://github.com/swiftyfinch/Pods"
  version "1.0.0"
  url "https://github.com/swiftyfinch/Pods/releases/download/#{version}/pods.zip"

  def install
    bin.install Dir["bin/*"]
  end
end
