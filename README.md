Flutter Location and Notification Permission App
This app demonstrates:

1.UI Design: Follows the provided layout with responsive design using MediaQuery.
2.Location & Notification Permissions: Buttons to request location and notification permissions.
3.Location Updates:
   Start/stop location updates with confirmation dialog.
   Displays notifications for starting/stopping updates.
   Saves location data to SharedPreferences every 10 seconds and shows it on the screen.

Setup
Dependencies
   pubspec.yaml
 
   permission_handler: ^10.2.0
   geolocator: ^10.1.0
   shared_preferences: ^2.1.0
   flutter_local_notifications: ^13.0.0

Permissions Configuration

   Android: Add location, notification permissions in AndroidManifest.xml.
   iOS/macOS: Add usage descriptions in Info.plist.
   Run the App
  
   
   flutter run
