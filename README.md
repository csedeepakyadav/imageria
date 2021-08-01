# Imageria Mobile Applicatiom ( Flutter )
(Documentation)

## How to run ?

### * Windows

#### -> VS Code 
* flutter pub get (in terminal )
* flutter run (in termninal)

#### -> Android Studio
* open project and click on run.

### * Mac

#### -> VS Code 
* pub get (in terminal )
* cd ios ( move to ios directory of project )
* pod install (in terminal)
* cd.. (interminal)
* flutter run (in termninal)

#### -> Xcode
* open ( project->ios->Runner.xcworkspace ) in xcode.
* click on run.

## Details

* Architecture used MVVM with the help of provider package.
* For State management Provider Package is used.
* For Http request dio package is used.


## Project Flow and In-depth Technical Details

* App starts.
* navigates to splash screen, here hold here for 2 seconds, Then Navigates to home screen.
* At home screen first it will check for internet with shimmer loader then it'will hit the image api and get the response,then json response will be stored in local model upon which ui will be build for Image list.
* On tapping load more button api will be hit with an incremented offset value, after getting result it will added to existing local model of image list.
* on taping single image it will navigate to detail screen, after filling the form it will check if form is validated then it will convert existing network image in local file then with the form data image will be sent in mutlipart with a loader, once it's succeeded, Success toast will be seen, upon failer a failer response will be seen.
* Orientation portrait up.
* Internet connectivity stream throughout the app.

## Validations

* Data validation.
* Http response and request validation.
* Form validation.
* Internet connectivity validation.
* Exception handling.

## Others

* Aspect ration have been maintained based on image size.
* Shimmer loader used.
* Sound Null-Safety

## Test

* Tested with android.
* Tested with iOS.
