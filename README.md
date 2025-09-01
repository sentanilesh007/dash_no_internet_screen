
<img width="1860" height="166" alt="dashstack_poster" src="https://github.com/user-attachments/assets/12f83877-3a1d-4bc2-876b-c5e551acc7ca" />

#   Customize No Internet Screen 
A customizable **No Internet Screen** for Flutter apps with a reusable widget.  
When your app has no connectivity, instead of a boring static screen, you can show users with customizable text and image.

## ✨ Features
🔌 Auto-detects internet connectivity using [`connectivity_plus`](https://pub.dev/packages/connectivity_plus)
✅ Automatically detects internet connectivity changes.  
✅ Displays a **No Internet screen** with custom image + message.  
✅ Retry button to re-check internet availability.  
✅ Supports add images and random messages text.  
✅ Plug & Play → Wrap your any widget and screens with `DashNoInternetScreen`.    

## 📸 Screenshots
| No Internet Screen | Example Screen |
|--------------------|----------------|
| <img width="400" height="711" alt="no_internet_screen" src="https://github.com/user-attachments/assets/ca0139af-c384-4a61-af21-5a8568268ea8" /> | <img width="400" height="711" alt="test_screen" src="https://github.com/user-attachments/assets/a88c3f40-e99d-465e-9df5-725b61900265" /> |

---
## How to use it?

### 1. Add dependency
Add this to your package's pubspec.yaml file:
```
dependencies:
  dash_no_internet_screen: <latest_version>
  ```
### 2. Install it
You can install packages from the command line:

with pub:

```
$ pub get
```
with Flutter:
``` 
$ flutter pub get
```
### 3. Import it
```
import 'package:dash_no_internet_screen/dash_no_internet_screen.dart';
``` 
### 4. Use it
[Sample](https://github.com/sentanilesh007/dash_no_internet_screen) app demonstrates how simple the usage of the library actually is.

Using `DashNoInterNetScreen` in your project is super simple .  

You just need to **wrap your screen with `DashNoInterNetScreen`**, and it will automatically handle the internet connectivity state for you.

---

## Basic usage

Add WithOut Image And Text Using BY Defult :


```
    return DashNoInterNetScreen(
      child: Scaffold(
        appBar: AppBar(title: const Text("Test Screen"), centerTitle: true),
        body: const Center(child: Text("your device online!", style: TextStyle(fontSize: 16))),
      ),
    );
  
```

Add custom Image and Text :

```
 ///wrap with DashNoInterNetScreen for your project any screen
    return DashNoInterNetScreen(
      image: 'assets/no_internet.png', //add it your image
      text: 'No internet? Please Check Your Internet Connection!', //add it your text
      child: Scaffold(
        appBar: AppBar(title: const Text("Test Screen"), centerTitle: true),
        body: const Center(child: Text("your device online!", style: TextStyle(fontSize: 16))),
      ),
    );
```

# Bugs and Feedback 
We welcome and appreciate any suggestions you may have for improvement. For bugs, questions, and discussions please use the  [GitHub Issues](https://github.com/sentanilesh007/dash_no_internet_screen/issues).

# Acknowledgments
It extends Flutter’s foundation to provide a ready-to-use, customizable "No Internet" screen. While Flutter offers powerful dash_no_internet_screen simplifies the process by combining widgets (like no internet avaiable to show image and text by defult and custom both) into a single package you can drop into any app.

# Contribution
The DashStack team enthusiastically welcomes contributions and project participation! There are a bunch of things you can do if you want to contribute! The Contributor Guide has all the information you need for everything from reporting bugs to contributing entire new features. Please don't hesitate to jump in if you'd like to, or even ask us questions if something isn't clear.

# Credits
`dash_no_internet_screen` is owned and maintained by the **Dashstack** team.  
Follow us for updates and new releases 🚀.


