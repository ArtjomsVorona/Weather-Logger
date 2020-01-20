# Weather Logger
iOS application to save weather conditions for user current location.

Main functionality:
- Once user presses "Update and Save" button the application retrieves the data received from the Openweathermap.org API, stores it locally with event date and displays it on screen.

Functionality:
- All data stored using UserDefaults.
- Alamofire is used for networking request.
- Current weather data is retrieved for user current location name, which is provided using CLLocationManager.
- User can share some part of current weather data via UIActivityViewController.
- Saved weatherData can be later deleted by user.


