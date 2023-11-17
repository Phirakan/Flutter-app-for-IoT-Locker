import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relay Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Relay Control'),
        ),
        body: LockerDataScreen(),
      ),
    );
  }
}

class LockerDataScreen extends StatelessWidget {
  Future<void> sendCommand(String command) async {
    var url = Uri.parse('http://192.168.1.7/$command');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('Command sent successfully');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending command: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
       image: DecorationImage(
            image: AssetImage('assets/img/locker.jpg'), 
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), 
              BlendMode.dstATop,
            ),
          ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/img/psuLogo.png', // แทนที่ด้วยที่อยู่ของรูปภาพของคุณ
                width: 200, // คุณสามารถปรับขนาดได้ตามความต้องการ
                height: 200,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  sendCommand('relayOn'); // เปิด Relay
                },
                child: Text('Unlock Locker'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  sendCommand('relayOff'); // ปิด Relay
                },
                child: Text('Lock Locker'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
