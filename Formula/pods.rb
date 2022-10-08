class Pods < Formula
  desc "🌱 Cozy pod install"
  homepage "https://github.com/swiftyfinch/Pods"
  version "0.1.2"
  url "https://github.com/swiftyfinch/Pods/releases/download/#{version}/pods.zip"

  def install
    bin.install Dir["bin/*"]
  end
end
