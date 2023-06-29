# copy-large-file

The Plugin copies a large File natively ...
- from the native-Bundle (iOS)...
- from the assets-folder (Android)...

--> ...and places it to your Application Documents Folder

it does the copying only if the file does not already exist at the Application Documents Folder location [same name].

The plugin method created is called **copyLargeFile**

The return-value of the copyLargeFile method delivers the fullNamePath of the copied (or already existing) large File inside the Application Documents Folder.

## Getting Started

### 1. Inside pubspec.yaml file of your Flutter project, add the following dependency:

```yaml
dependencies:
  flutter:
    sdk: flutter
  copy_large_file: ^0.0.1
```
(hint: the version might be different in the meantime. Make sure to include the newest version of the package plugin).

### 2. Import the package

```dart
import 'package:copy_large_file/copy_large_file.dart';
```

### 3. usage

```dart

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> someMethod() async {
    String fullPathName;
    try {
      String fullPathName = await LargeFileCopy("test.txt").copyLargeFile;
      //...
    } on PlatformException {
      //...
    }
  }
```

### 4. native preparations

iOS:
- open your Flutter-project's /ios/Runner.xcworkspace in Xcode
- inside Runner, create a new Group and call it for example "Bundle"
- inside Bundle (or whatever you called your Group), drag and drop your large File (make sure to select "Copy items if needed")
- (optional): to check if all is correct for iOS - go to your Flutter project's ios/Runner/ Folder and see if the added large File is there...

Android:

- open your Flutter-project's /android/my_flutter_project_name_android.iml in Android Studio
- inside app/app/src/main/assets/ folder drag and drop your large file (create assets folder if it is not already there)
- (optional): to check if all is correct for Android - go to your Flutter project's android/src/main/assets/ Folder and see if the added large File is there...
