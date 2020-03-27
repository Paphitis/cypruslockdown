# ![](android/app/src/main/res/mipmap-hdpi/ic_launcher.png) Cyprus Lockdown ©Copyright 2020

- During this time that our Country needs us to be patient and **#stayathome**.
- This application is a tool that help you create the sms with correct format and data. 

### Steps to buld the app:
- install Flutter SDK.
- for Android platform install Android SDK, Android SDK Platform-Tools, and ANdroid SDK Build-Tools.
- for platform iOS install XCode.

### Build and run the app:
- open terminal and navigate to the app directory.
- get dependencies

```bash
$flutter pub get
```

-run the app (connect a device first)


```bash
$flutter run
```

### Build Android app:
- reference the keystore from the app<br><br>
  Create a file named <app dir>/android/key.properties that contains a reference to your keystore:
  storePassword=<password from previous step>
  keyPassword=<password from previous step>
  keyAlias=key
  storeFile=<location of the key store file, such as /Users/<user name>/key.jks>
  
- open terminal and navigate to the app directory
- build an app bundle

```bash
  $ flutter build appbundle --release
  ```
### Build release version of iOS app:

- select developer team<br>
    Navigate to your target’s settings in Xcode:

  - In Xcode, open Runner.xcworkspace in your app’s ios folder.
  - To view your app’s settings, select the Runner project in the Xcode project navigator. Then, in the main view sidebar, select the Runner target.
  - Select the General tab.
    In the Signing section:<br>

    **Automatically manage signing**<br>
    Whether Xcode should automatically manage app signing and provisioning. This is set true by default, which should be sufficient for most apps. For more complex scenarios, see the Code Signing Guide.<br><br>
    **Team**<br>
    Select the team associated with your registered Apple Developer account. If required, select Add Account…, then update this setting.
- close Xcode workspace
- open terminal and navigate to the app directory
- create a release build

```bash
  $ flutter build ios --release
  ```
- re-open Xcode workspace<br><br>
  *In Xcode, configure the app version and build:*
  - In Xcode, open Runner.xcworkspace in your app’s ios folder.
  - Select Product > Scheme > Runner.
  - Select Product > Destination > Generic iOS Device.
  - Select *Runner* in the Xcode project navigator, then select the **cypruslockdown** target in the settings view sidebar.
  - In the Identity section, update the Version to the user-facing version number you wish to publish.
  - In the Identity section, update the Build identifier to a unique build number used to track this build on App Store Connect. Each upload requires a unique build number.<br>
   
  *Finally, create a build archive and upload it to App Store Connect:*

  - Select Product > Archive to produce a build archive.
  - In the sidebar of the Xcode Organizer window, select your iOS app, then select the build archive you just produced.
  - Click the Validate App button. If any issues are reported, address them and produce another build. You can reuse the same build ID until you upload an archive.
  - After the archive has been successfully validated, click Distribute App. You can follow the status of your build in the Activities tab of your app’s details page on App Store Connect.<br>
  
*For more information visit the Flutter documentation page:*
  - [Flutter Documentation](https://flutter.dev/docs) 
  - [Build and release an Android app](https://flutter.dev/docs/deployment/android) 
  - [Build and release an iOS app](https://flutter.dev/docs/deployment/ios)
