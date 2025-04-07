# Chef Maker

<div style="background-color: #A1C181; padding: 20px; border-radius: 10px; margin-bottom: 20px;">
  ![Chef Maker Logo](Assets/logo.png)
  <h2 style="color: white; text-align: center; margin-top: 10px;">Smart Recipe Discovery</h2>
</div>

## About

Chef Maker is a modern recipe discovery application powered by artificial intelligence. It helps you find and create delicious recipes based on ingredients you have or cuisines you want to explore. With a clean, minimal design and powerful features, Chef Maker transforms the way you interact with food.

## Features

- 🔍 **Smart Recipe Search** - Find recipes based on ingredients or categories
- 🧠 **AI-Powered Recommendations** - Get personalized recipe suggestions
- 📱 **Beautiful Minimal Design** - Clean interface with intuitive navigation
- 📊 **Nutritional Information** - Detailed nutrition facts for every recipe
- 🔖 **Save Favorites** - Keep track of recipes you love

## Color Scheme

Our application uses a refreshing and natural color palette:

<div style="display: flex; margin: 20px 0;">
  <div style="background-color: #A1C181; width: 100px; height: 100px; border-radius: 10px; margin-right: 10px; display: flex; align-items: center; justify-content: center;">
    <span style="color: white; font-weight: bold;">#A1C181</span>
  </div>
  <div style="background-color: #619B8A; width: 100px; height: 100px; border-radius: 10px; margin-right: 10px; display: flex; align-items: center; justify-content: center;">
    <span style="color: white; font-weight: bold;">#619B8A</span>
  </div>
  <div style="background-color: #439775; width: 100px; height: 100px; border-radius: 10px; margin-right: 10px; display: flex; align-items: center; justify-content: center;">
    <span style="color: white; font-weight: bold;">#439775</span>
  </div>
</div>

## App Screenshots

🚧 Work in progress – screenshots will be added soon as development progresses.
<!--![Home Screen](screenshots/home_screen.png)-->
<!--![Recipe Details](screenshots/recipe_details.png)-->
<!--![Search View](screenshots/search_view.png)-->


## Technologies Used

- **SwiftUI** - For building the modern user interface
- **Combine** - For reactive programming
- **Spoonacular API** - For recipe data
- **Firebase** - For authentication, cloud storage, and analytics
- **AI Integration** - For personalized recommendations

## Getting Started

1. Clone the repository
2. Open `Chef Maker.xcodeproj` in Xcode
3. Add your Spoonacular API key to `Secrets.xcconfig`
4. Set up Firebase:
   - Create a project in the [Firebase Console](https://console.firebase.google.com/)
   - Add an iOS app to your Firebase project
   - Download the `GoogleService-Info.plist` file and add it to your Xcode project
   - Install Firebase SDK via Swift Package Manager or CocoaPods
5. Build and run the application

## API Integration

### Spoonacular API
Chef Maker uses the Spoonacular API for recipe data. You'll need to:

1. Get an API key from [Spoonacular](https://spoonacular.com/food-api)
2. Add your API key to the `Secrets.xcconfig` file
3. The application will automatically use your API key for all requests

### Firebase Integration

Chef Maker leverages several Firebase services:

- **Authentication** - For user sign-up and login
- **Cloud Firestore** - For storing user recipes and favorites
- **Storage** - For user-uploaded images
- **Analytics** - For understanding user behavior
- **Crashlytics** - For monitoring app stability

To set up Firebase:

1. Follow the [Firebase iOS setup guide](https://firebase.google.com/docs/ios/setup)
2. Enable required services in the Firebase Console
3. Configure authentication providers (Email, Google, Apple, etc.)
4. Set up Firestore security rules for data protection

## Design Philosophy

Chef Maker follows a minimalist design approach with these principles:

- **Simplicity** - Focus on essential features with minimal clutter
- **Usability** - Intuitive interface that's easy to navigate
- **Visual Harmony** - Consistent use of our natural color palette
- **Focus on Content** - Beautiful food imagery takes center stage

## Future Updates

- 📝 Recipe creation with AI assistance
- 🍽️ Meal planning features
- 📱 iPad support with adaptive layouts

---

<p align="center" style="color: #619B8A;">Made with ❤️ for food lovers everywhere</p>
