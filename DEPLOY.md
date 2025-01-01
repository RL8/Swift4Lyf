# Deployment Guide

## Prerequisites

1. Install Node.js and npm from [nodejs.org](https://nodejs.org)
2. Install Firebase CLI:
```bash
npm install -g firebase-tools
```

## First-time Setup

1. Login to Firebase:
```bash
firebase login
```

2. Set up your Firebase project:
- Go to [Firebase Console](https://console.firebase.google.com)
- Create a new project or select existing one
- Enable required services (Authentication, Firestore)

3. Initialize Firebase in your project:
```bash
firebase init
```
Select the following options:
- Hosting
- Firestore
- Use existing project
- Select your project
- Accept default options for hosting

4. Update `.env.prod` with your Firebase configuration:
```
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_APP_ID=your-app-id
FIREBASE_API_KEY=your-api-key
FIREBASE_MESSAGING_SENDER_ID=your-sender-id
FIREBASE_STORAGE_BUCKET=your-storage-bucket
```

## Deployment

### Option 1: Using deploy script

Run the deployment script:
```bash
./deploy.bat
```

### Option 2: Manual deployment

1. Clean and get dependencies:
```bash
flutter clean
flutter pub get
```

2. Build web version:
```bash
flutter build web --release
```

3. Deploy to Firebase:
```bash
firebase deploy
```

## Post-deployment

1. Verify your deployment:
- Visit your Firebase Hosting URL
- Test core functionality
- Check Firebase Console for any errors

2. Monitor your app:
- Check Firebase Analytics
- Monitor Firestore usage
- Check Authentication status

## Troubleshooting

### Common Issues

1. Build fails:
```bash
flutter clean
flutter pub get
flutter build web --release
```

2. Firebase deployment fails:
```bash
firebase logout
firebase login
firebase deploy
```

3. Firebase initialization fails:
- Check `.env.prod` configuration
- Verify Firebase project settings
- Check web/index.html for correct SDK versions

### Support

For issues:
1. Check Firebase Console
2. Review Firebase Hosting logs
3. Check Flutter build logs
