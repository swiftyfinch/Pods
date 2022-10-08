<p align="center">
  <b>🌱 Cozy Pod Install</b>
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/64660122/194710052-dca8d92a-7262-41e5-8b92-ec2e460fccca.gif" width="600"/>
</p>
<p align="center">  
  <a href="https://swiftpackageindex.com/swiftyfinch/Pods"><img src="https://img.shields.io/endpoint?color=orange&label=Swift&logo=swift&logoColor=white&url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswiftyfinch%2FPods%2Fbadge%3Ftype%3Dswift-versions" /></a>
  <a href="https://swiftpackageindex.com/swiftyfinch/Pods"><img src="https://img.shields.io/endpoint?label=Platform&url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswiftyfinch%2FPods%2Fbadge%3Ftype%3Dplatforms" /></a>
  <br>
  <a href="https://brew.sh"><img src="https://img.shields.io/badge/Homebrew-8B4513" /></a>
  <a href="https://github.com/yonaskolb/Mint"><img src="https://img.shields.io/badge/Mint-darkgreen?logo=leaflet&logoColor=white" /></a>
  <a href="https://swiftpackageindex.com/swiftyfinch/Pods"><img src="https://img.shields.io/badge/Swift_Package_Index-red?logo=swift&logoColor=white" /></a>
  <br>
  <img src="https://img.shields.io/badge/Press_★_for_pay_respect-white?logo=github&logoColor=black" />
  <a href="https://twitter.com/swiftyfinch"><img src="https://img.shields.io/badge/SwiftyFinch-blue?logo=twitter&logoColor=white" /></a>
</p>

## Using `CocoaPods` in a more convenient way ☕️

🦄 Automagically adding prefix `bundle exec` if **Gemfile** is found<br>
🚑 Handling [Bundler](https://bundler.io) **missing gems** error → `bundle install`<br>
🚑 Handling [CocoaPods](https://cocoapods.org) **out-of-date source repos** error → `pod repo update`<br>
🌍 You don't need to manually sync all your aliases between all macs<br>
✨ Output fancy log and animations<br>
🔔 Playing bell sound in the end<br>
🚀 Swiftish!

That utility helps me a lot. I wonder if there is somebody who finds it useful too.<br>
It's the Swift version of my older repository 🌱 [Pods Install](https://github.com/swiftyfinch/PodsInstall)<br>
You can read 📖 [more](https://swiftyfinch.github.io/en/2020-05-23-cozy-pod-install/) in my blog.
<br>

## Download binary with [Homebrew](https://brew.sh) 🍺

```bash
brew tap swiftyfinch/Pods https://github.com/swiftyfinch/Pods.git
brew install pods
```

## Quick start with <a href="https://github.com/yonaskolb/Mint">Mint</a> 🌱

```bash
brew install mint
mint install swiftyfinch/pods

# Now on Mint 0.17.0 you'll need to add ~/.mint/bin to your $PATH
# For example, add this to your ~/.zshrc file and relaunch terminal
export PATH=$HOME/.mint/bin:$PATH
```
Watch 🎬 [installation demo](https://github.com/swiftyfinch/Rugby/discussions/71)<br>
It's from my another project, but the idea is the pretty same.
<br>

## How to use 🏈

Run in your project directory instead of `pod install`:
```bash
pods install
# or just
pods

pods update Alamofire Snapkit
# or any subcommand
pods <subcommand>
```
```bash
# or in quiet mode (like in demo video)
pods -q
```
<br>

### `Author`

Vyacheslav Khorkov\
Feel free to contact me 📮
