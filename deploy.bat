@echo off
echo Building and deploying Taylor Swift Album Guessing Game...

REM Clean build directory
echo Cleaning...
flutter clean

REM Get dependencies
echo Getting dependencies...
flutter pub get

REM Build web version
echo Building web version...
flutter build web --release

REM Deploy to Firebase Hosting
echo Deploying to Firebase...
firebase deploy --only hosting

echo Deployment complete!
