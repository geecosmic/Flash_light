
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(FlashlightApp());
}

class FlashlightApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlashlightHome(),
    );
  }
}

class FlashlightHome extends StatefulWidget {
  @override
  _FlashlightHomeState createState() => _FlashlightHomeState();
}

class _FlashlightHomeState extends State<FlashlightHome> {
  bool _isOn = false;

  void _toggleFlashlight() async {
    try {
      if (_isOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        _isOn = !_isOn;
      });
    } catch (e) {
      print('Could not toggle flashlight: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flashlight App',
          style: TextStyle(color: Colors.white), // Centered and white title
        ),
        centerTitle: true, // Center aligns the title
        backgroundColor: Colors.deepOrange[700], // Red background color
      ),
      body: Container(
        color: Colors.blue[900], // Dark blue background color
        child: Center(
          child: ElevatedButton(
            onPressed: _toggleFlashlight,
            child: Text(
              _isOn ? 'Turn Off' : 'Turn On',
              style: TextStyle(color: Colors.white), // White text color
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.yellow; // Red background color when pressed
                  }
                  return Colors.red; // White background color by default
                },
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Button padding
              ),
            ),
          ),
        ),
      ),
    );
  }
}
