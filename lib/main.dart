import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Method Channel Demo'),
        ),
        body: const BatteryApp(),
      ),
    );
  }
}

class BatteryApp extends StatefulWidget {
  const BatteryApp({super.key});

  @override
  State<BatteryApp> createState() => _BatteryAppState();
}

class _BatteryAppState extends State<BatteryApp> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    } catch (e) {
      batteryLevel = "Failed to get battery level: '$e'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: _getBatteryLevel,
            child: const Text('Get Battery Level'),
          ),
          Text(_batteryLevel),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _batteryLevel = 'Unknown battery level.';
                });
              },
              child: const Text("reset battery level")),
        ],
      ),
    );
  }
}
