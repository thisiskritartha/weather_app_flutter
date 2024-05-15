# Weather Checker App
Weather App is a simple Flutter application that allows users to check the current weather conditions for a specific location.

## Features
- Current Weather: View the current weather conditions including temperature, humidity, wind speed, and weather description.
- Location Search: Search for weather information by entering a location name.
- GPS Location: Automatically fetch the weather data based on the user's current GPS location.
- Persistent Storage: Save the user's preferred location for future use.

## Screenshots

<img src="https://github.com/thisiskritartha/weather_app_flutter/blob/main/assets/screenshot/1.jpeg" alt="Helper Screen" height="600px"  width="300"/>      <img src="https://github.com/thisiskritartha/weather_app_flutter/blob/main/assets/screenshot/2.jpeg" alt="Home page screen" height="600px"  width="300"/>      <img src="https://github.com/thisiskritartha/weather_app_flutter/blob/main/assets/screenshot/3.jpeg" alt="Error page" height="600px"  width="300"/>

## Installation
To run this application locally, you need to have Flutter installed on your machine. If you haven't already installed Flutter, you can follow the instructions on the official Flutter website.
1) Clone this repository:
git clone https://github.com/thisiskritartha/weather_app_flutter.git
2) Navigate to the project directory:
cd weather_app_flutter
3) Install dependencies:
flutter pub get
4) Run the app:
flutter run

### Or you can directly install the apk from the given link:
https://drive.google.com/drive/folders/1wfSI8LdPhSR9ZkdqvgFGosvg4bVcyvSZ?usp=sharing

## Usage
- Upon launching the app, you will see the current weather conditions for your current location (if GPS location is enabled).
- You can search for weather information by entering a location name in the search field and tapping the search button.
- The app will display the current weather conditions for the specified location.
- You can also save your preferred location for future use.

## Dependencies
- Get - State management and navigation
- Geolocator - Fetching GPS location
- http - HTTP requests
- Shared Preferences - Persistent storage