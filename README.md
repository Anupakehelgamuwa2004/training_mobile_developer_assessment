# Training Mobile Developer Assessment

A cross-platform Flutter application that demonstrates user authentication, dynamic product listings from a mock API, and detailed product views. This project is built to showcase essential mobile development skills including state management, API integration, and local data storage.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Future Improvements](#future-improvements)
- [License](#license)
- [Contact](#contact)

---

## Overview

This project is designed as an assessment for mobile developers. It includes:

- **User Authentication:**  
  Secure login and registration using email and password with local session storage.
  
- **Dynamic Dashboard:**  
  A product listing fetched dynamically from a mock API and displayed in a refined grid layout.
  
- **Product Details:**  
  Detailed view for each product with images, price, and description.
  
- **Logout Functionality:**  
  Securely clears user sessions and navigates back to the login screen.

The app is fully functional on both Android and iOS.

---

## Features

- **User Authentication:**  
  - Registration and Login using email and password  
  - Local session management with SharedPreferences
  
- **Dashboard:**  
  - Dynamic product grid fetched from a simulated API  
  - Professional UI with clean typography and minimalist design
  
- **Product Details:**  
  - Detailed view of selected product including image, title, price, and description
  
- **Logout:**  
  - Secure logout functionality that clears user sessions

---

## Tech Stack

- **Flutter (Dart):** For building the cross-platform mobile application  
- **Provider:** For state management  
- **SharedPreferences:** For local storage of session data  
- **HTTP:** For simulating API calls to fetch product data  

---

## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/training_mobile_developer_assessment.git
   cd training_mobile_developer_assessment

   Install Dependencies:
---
Set Up Your Device/Emulator
Connect an Android emulator, iOS simulator, or a physical device.
---
Usage
Running the App
Use the following command to run the app on your connected device/emulator:
---
bash
Copy
flutter run
User Flow
Register:
Create a new account using your email and password.
---
Login:
Log in using your registered credentials.
---
Dashboard:
View a dynamic grid of products fetched from the mock API.
---
Product Details:
Tap on any product to view detailed information.
---
Logout:
Use the logout button in the dashboard to clear your session and return to the login screen.
---
---

Future Improvements
Backend Integration:
Replace the mock API with a real backend for user authentication and product data.
---
UI/UX Enhancements:
Further refine the UI with animations and more sophisticated design elements.
---
Testing:
Implement comprehensive unit and integration tests.
---
Internationalization:
Add support for multiple languages.
---
License
This project is licensed under the MIT License. See the LICENSE file for details.
---
Approach
---
This project follows a modular approach to separate concerns and enhance maintainability:
---
State Management:
---
Uses Provider to inject and manage state across the application.
---
Reactive updates ensure the UI stays in sync with the authentication state and product data.
---
API Integration:
---
Utilizes the http package to asynchronously fetch product data from the Fake Store API.
---
Implements JSON parsing to convert API responses into Dart objects.
---
Local Persistence:
---
Implements SQFLite to manage local storage of user data.
---
Uses SharedPreferences to persist authentication tokens between app launches.
---
Navigation:
---
Leverages Flutter’s routing system to navigate between screens (login, register, home, detail).
---
Incorporates hero animations for smooth transitions between the product list and detail screens.
---
Modular Architecture:
---
The codebase is organized into clear, distinct folders for models, providers, screens, and services.
---
This separation allows for easy scalability and maintenance.
---
Contact
For questions or suggestions, please contact:
---
Your Emmail: anupakehel8403@gmail.com
---
GitHub: Anupakehel2004
---
