# Delivery of Food - Food Sharing App

A Flutter mobile application designed to facilitate food sharing within communities. This app connects food donors with those who need food, helping reduce food waste while addressing hunger.

## 📱 Features

### User Features
- **User Authentication**: Sign up, login, and password recovery using Firebase Authentication
- **Browse Food Items**: View available food items across categories (Full Meals, Fruits, Tiffins, Vegetables)
- **Food Details**: See detailed information about each food item with images
- **Order Management**: Add items to cart and track orders
- **Profile Management**: Update profile with custom images, edit user information
- **Location Services**: Integrated Google Maps for delivery coordination
- **Push Notifications**: Firebase Cloud Messaging for real-time updates
- **Settings**: Customize notifications, provide feedback, and access help & support

### Admin Features
- **Admin Login**: Secure admin authentication
- **Add Food Items**: Upload food items with images to different categories
- **Manage Inventory**: View and manage all food items across categories
- **Firebase Storage**: Store and manage food item images

## 🛠️ Tech Stack

- **Framework**: Flutter 3.5.0+
- **Backend**: Firebase
  - Firebase Authentication
  - Cloud Firestore
  - Firebase Storage
  - Firebase Cloud Messaging
- **State Management**: StatefulWidget
- **Navigation**: Curved Navigation Bar
- **Location**: Google Maps Flutter
- **Image Handling**: Image Picker, Cached Network Image
- **Storage**: Shared Preferences

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  curved_navigation_bar: ^1.0.6
  image_picker: ^0.8.4+4
  url_launcher: ^6.0.20
  firebase_core: ^3.6.0
  cloud_firestore: ^5.4.4
  firebase_auth: ^5.3.1
  firebase_storage: ^12.3.4
  http: ^1.2.2
  firebase_messaging: ^15.1.3
  cached_network_image: ^3.4.1
  random_string: ^2.3.1
  shared_preferences: ^2.3.2
  google_maps_flutter: ^2.9.0
  cupertino_icons: ^1.0.8
```

## 📂 Project Structure

```
lib/
├── admin/
│   ├── add_food.dart         # Admin interface to add food items
│   ├── admin_login.dart      # Admin authentication
│   └── home_admin.dart       # Admin dashboard
├── pages/
│   ├── bottomnav.dart        # Bottom navigation bar
│   ├── home.dart             # Main home screen
│   ├── login.dart            # User login
│   ├── signup.dart           # User registration
│   ├── profile.dart          # User profile management
│   ├── details.dart          # Food item details
│   ├── order.dart            # Order tracking
│   ├── welcome_page.dart     # Initial welcome screen
│   ├── settings.dart         # App settings
│   └── forgotpassword.dart   # Password recovery
├── services/
│   └── database.dart         # Firestore database services
├── widget/
│   └── widget_support.dart   # Reusable custom widgets
└── main.dart                 # App entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.5.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Firebase account

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/DileepKumarGrandhi/delivery_of_food.git
   cd delivery_of_food
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android/iOS apps to your Firebase project
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place configuration files in respective directories:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`
   - Enable Authentication, Firestore, and Storage in Firebase Console

4. **Configure Google Maps (Optional)**
   - Get API key from Google Cloud Console
   - Add to `android/app/src/main/AndroidManifest.xml` and iOS configuration

5. **Run the app**
   ```bash
   flutter run
   ```

## 🎯 How It Works

### User Flow
1. **Welcome Screen**: Users choose between Admin or User registration
2. **Authentication**: New users sign up with email/password, existing users login
3. **Home Screen**: Browse food items by category (Full Meals, Fruits, Tiffins, Vegetables)
4. **Food Details**: View detailed information and select quantity
5. **Add to Cart**: Add items to order list
6. **Order Tracking**: View and manage orders
7. **Profile Management**: Update profile picture and personal information

### Admin Flow
1. **Admin Login**: Secure admin authentication
2. **Admin Dashboard**: View all food items across categories
3. **Add Food Items**: Upload food items with:
   - Name
   - Description
   - Image
   - Category selection
4. **Firebase Storage**: Images are automatically uploaded to Firebase Storage
5. **Firestore Database**: Item details are stored in category-specific collections

### Data Structure
- **Users Collection**: Stores user profile information
- **Category Collections** (FullMeal, Fruits, Tiffins, Vegetables): Store food items
  - Name
  - Detail
  - Image URL

## 🎨 UI Features

- **Custom Fonts**: Poppins font family for consistent typography
- **Curved Navigation**: Bottom navigation with smooth curved animations
- **Image Caching**: Efficient image loading with caching
- **Responsive Design**: Adapts to different screen sizes
- **Material Design**: Clean and modern UI following Material Design guidelines

## 🔐 Security

- Firebase Authentication for secure user management
- Password validation and recovery
- Admin-only access for food management
- Secure data storage with Firebase Firestore rules

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Linux
- ✅ macOS
- ✅ Windows

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is a private repository. Please contact the owner for usage permissions.

## 👨‍💻 Developer

**Dileep Kumar Grandhi**
- GitHub: [@DileepKumarGrandhi](https://github.com/DileepKumarGrandhi)

## 📞 Support

For issues and questions, please open an issue in the GitHub repository.

## 🙏 Acknowledgments

- Flutter and Dart teams for the amazing framework
- Firebase for backend services
- Open source community for various packages used in this project

---

**Note**: This is a food sharing application aimed at reducing food waste and helping communities. "A simple act of sharing food can have a profound impact on someone's life."