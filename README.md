# 🌱 Cozy pod install

<img src="https://user-images.githubusercontent.com/64660122/140637141-e0a341b3-9ede-4c6f-81e8-db95e457bfa6.mp4" width="600"/>

<p>
<img src="https://img.shields.io/badge/Swift-orange?logo=swift&logoColor=white" />
<a href="https://github.com/yonaskolb/Mint"><img src="https://img.shields.io/badge/Mint-darkgreen?logo=leaflet&logoColor=white" /></a>
<a href="https://cocoapods.org"><img src="https://img.shields.io/badge/CocoaPods-brown?logo=cocoapods&logoColor=white" /></a>
<a href="https://twitter.com/swiftyfinch"><img src="https://img.shields.io/badge/@swiftyfinch-blue?logo=twitter&logoColor=white" /></a>
</p>

## Using `pod install` in a more convenient way ☕️

🦄 Automagically adding prefix `bundle exec` if **Gemfile** is found<br>
🚑 Handling [Bundler](https://bundler.io) **missing gems** error → `bundle install`<br>
🚑 Handling [CocoaPods](https://cocoapods.org) **out-of-date source repos** error → `pod repo update`<br>
✨ Output fancy log and animations<br>
🔔 Playing bell sound in the end<br>
🚀 Swiftish!

That utility helps me a lot. I wonder if there is somebody who finds it useful too.<br>
It's the Swift version of my older repository 🌱 [PodsInstall](https://github.com/swiftyfinch/PodsInstall)<br>
You can read 📖 [more](https://swiftyfinch.github.io/en/2020-05-23-cozy-pod-install/) in my blog.
<br>

## Quick start with <a href="https://github.com/yonaskolb/Mint">Mint</a> 🌱

```bash
brew install mint
mint install swiftyfinch/pods

# Now on Mint 0.17.0 you'll need to add ~/.mint/bin to your $PATH
# For example, add this to your ~/.zshrc file and relaunch terminal
export PATH=$HOME/.mint/bin:$PATH
```
Watch 🎬 [installation demo](https://github.com/swiftyfinch/Rugby/discussions/71)<br>
It's from my other project, but the idea is the pretty same.
<br>

## How to use 🏈

Run in your project directory instead of `pod install`:
```bash
pods install
```
```bash
# or just
pods
```
```bash
# or in quiet mode (like in demo video)
pods -q
```
<br>

### `Author`

Vyacheslav Khorkov\
Twitter: [@SwiftyFinch](https://twitter.com/swiftyfinch)\
Blog: [swiftyfinch.github.io](https://swiftyfinch.github.io/en)\
Feel free to contact me ☎️
