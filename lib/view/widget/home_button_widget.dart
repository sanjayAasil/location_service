import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../common/global.dart';
import '../../provider/location_service_provider.dart';
import '../../service/location_service.dart';
import '../../service/notification_service.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    print('checkkk media query width $screenWidth');
    return Container(
      color: Colors.black87,
      width: screenWidth,
      child: screenWidth < 600 ? const _MobileView() : const _TabOrWebView(),
    );
  }
}

class ButtonTile extends StatelessWidget {
  final Color color;
  final String text;
  final GestureTapCallback callBack;

  const ButtonTile({super.key, required this.color, required this.text, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 50,
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class _MobileView extends StatelessWidget {
  const _MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context, listen: true);
    return Column(
      children: [
        ButtonTile(
          color: CupertinoColors.activeBlue,
          text: 'Request Location Permission',
          callBack: () => LocationService().requestLocationPermission(context),
        ),
        ButtonTile(
          color: Colors.yellow,
          text: 'Request Notification Permission',
          callBack: () => NotificationService().requestNotificationPermission(context),
        ),
        ButtonTile(
          color: Colors.green,
          text: 'Start Location Update',
          callBack: () => _startLocationUpdateButton(context, locationProvider),
        ),
        ButtonTile(
          color: Colors.redAccent,
          text: 'Stop Location Update',
          callBack: () => _stopLocationUpdateButton(context, locationProvider),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _TabOrWebView extends StatelessWidget {
  const _TabOrWebView({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context, listen: true);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ButtonTile(
                color: CupertinoColors.activeBlue,
                text: 'Request Location Permission',
                callBack: () => LocationService().requestLocationPermission(context),
              ),
            ),
            Expanded(
              child: ButtonTile(
                color: Colors.yellow,
                text: 'Request Notification Permission',
                callBack: () => NotificationService().requestNotificationPermission(context),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ButtonTile(
                color: Colors.green,
                text: 'Start Location Update',
                callBack: () => _startLocationUpdateButton(context, locationProvider),
              ),
            ),
            Expanded(
              child: ButtonTile(
                color: Colors.redAccent,
                text: 'Stop Location Update',
                callBack: () => _stopLocationUpdateButton(context, locationProvider),
              ),
            ),
          ],
        )
      ],
    );
  }
}

_startLocationUpdateButton(
  BuildContext context,
  LocationProvider locationProvider,
) async {
  if (await Permission.notification.isDenied) {
    if (context.mounted) {
      showToast(context, 'Turn on Notification Permission');
    }
    return;
  }
  if (await Permission.location.isDenied) {
    if (context.mounted) {
      showToast(context, 'Turn on Location Permission');
    }
    return;
  }

  if (!await showPlatformAlert(title: 'Alert', message: 'Do you want to start?')) {
    return;
  }
  locationProvider.startLocationUpdates();

  NotificationService().showStartNotification();

  if (context.mounted) {
    showToast(context, 'Live Location will be updated every 10 seconds', duration: const Duration(seconds: 2));
  }
}

_stopLocationUpdateButton(BuildContext context, LocationProvider locationProvider) {
  locationProvider.stopLocationUpdates();
  showToast(context, 'Location service has been stopped');
  NotificationService().showStopNotification();
}
