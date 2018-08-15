# EAAlertView
iOS 11 Style Alerts

<p align="center">
<img src="https://img.shields.io/badge/Swift-4.0-orange.svg" alt="Swift 4.0"/>
<img src="https://img.shields.io/badge/platform-iOS-brightgreen.svg" alt="Platform: iOS"/>
<img src="https://img.shields.io/badge/Xcode-9%2B-brightgreen.svg" alt="XCode 9+"/>
<img src="https://img.shields.io/badge/iOS-11%2B-brightgreen.svg" alt="iOS 11"/>
<img src="https://img.shields.io/badge/licence-MIT-lightgray.svg" alt="Licence MIT"/>
</a>
</p>

# Alerts & Pickers

Alerts with TextField, TextView, DatePicker, PickerView

## Usage

<div align = "center">
<img src="/Resources/code.png" width="350" />
<img src="/Resources/loading.png" width="350" />
</div>

- New Alert

```swift
let alert = EAAlertView(appearance: appearance)
// or
let alert = EAAlertView()
```

- Set and styling message

```swift
let appearance = EAAlertView.EAAppearance(
kTextFieldHeight: 60,
kButtonHeight: 60,
showCloseButton: false,
shouldAutoDismiss: false
)
```
- Add button with image

```swift
alert.addAction(image: image, title: "Title", color: .black, style: .default) { action in
// completion handler
}
```

* Show Alert

```swift
// show alert
_ = alert.show("Title", subTitle: "subtitle")
```


## Installing

#### Cocoapods

 `pod 'EAAlertView'`

## Requirements

* Swift 4
* iOS 11 or higher

## Authors

* **Egzon Arifi** -  [egzonarifi](https://github.com/egzonarifi)

## Communication

* If you **found a bug**, open an issue.
* If you **have a feature request**, open an issue.
* If you **want to contribute**, submit a pull request.

## License

This project is licensed under the MIT License.
