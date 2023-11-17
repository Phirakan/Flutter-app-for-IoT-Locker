import 'package:flutter/material.dart';
import 'package:flutterprojectiot/screen/login.dart';
import 'package:flutterprojectiot/screen/register.dart';
import 'wifi_config.dart'; // นำเข้าหน้า config WiFi

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/img/Logo.png",
              width: 100,
              height: 100,
            ),
            Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.wifi), // ไอคอน WiFi
            onPressed: () {
              // เมื่อกดไอคอน WiFi ให้ Redirect ไปยังหน้า config WiFi
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => WiFiConfigPage()),
              );
            },
          ),
        ],
        backgroundColor: Color.fromARGB(223, 18, 73, 255),
      ),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Welcome !',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Image.asset("assets/img/R.png"),
              Text(
                ' ความปลอดภัยของทรัพย์สิน คุณคือผู้ควบคุม ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 15, 1, 0),
                ),
              ),
              SizedBox(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  icon: Icon(Icons.login),
                  label: Text("Login", style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text("Create Account", style: TextStyle(fontSize: 20)),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    );
  }
}
