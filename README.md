## Mobile App iOS
### iOS Integration

Welcome to iosCashfreeSDK repository. This repo hosts both the iOS Library iosCashfreeSDK as well as a Example App to get you started.
The Detailed documentation is available [here](http://docs.gocashfree.com/docs/v1/?swift#mobile-app-ios).

<b> Add the configuration keys and values to your project's info.plist </b>

```html
<key>CF_ENV</key>
<string>TEST</string>
<key>CF_URL</key>
<string>https://YOURDOMAIN.com/checksumjson</string>
<key>CF_MERCHANT_NAME</key>
<string>Your Merchant Name</string>
<key>CF_API_KEY</key>
<string>1xxxxxxxxxxxxxxxxxxxxxx4</string>
```

<b> Steps for using the iosCashfreeSDK </b>

1.  The iosCashfreeSdk should be dragged onto your iOS app project file structure (Copy check mark enabled in Xcode prompt).

2.  Then click the "+" button on "Embedded Binaries" under the "General" tab of your ios app project file.

3.  Select iosCashfreeSdk.framework, and click Finish button.

4.  Add the Swift [code snippets](https://docs.cashfree.com/docs/ios/guide/) to your ViewController.swift
