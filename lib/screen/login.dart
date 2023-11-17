import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'LockerSelect.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> login(String username, String pass) async {
    try {
      String url = "https://mosuuuu.tech/lockerprox/api/login.php";

      final response = await http.post(
        Uri.parse(url),
        body: {
          "username": username,
          "password": pass,
        },
      );

      var data = json.decode(response.body);
      print('Data: $data');

      
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เข้าสู่ระบบ'),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/img/psuLogo.png",
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              Container(
                width: 200, 
                child: TextFormField(
                  controller: _username,
                  decoration: InputDecoration(
                    hintText: 'ชื่อผู้ใช้',
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 200, // กำหนดความกว้างของ TextFormField ตามที่คุณต้องการ
                child: TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                    hintText: 'รหัสผ่าน',
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 0, 0), // สีพื้นหลังปุ่ม
                ),
                onPressed: () {
                  login(_username.text.trim(), _password.text.trim());
                  //Redirect to Locker.dart
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LockerDataScreen()),
                  );
                 
                },
                child: Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 25,
                  ),
                ),
              ),
              // เพิ่ม Widget เพิ่มเติมที่ต้องการตรงนี้
            ],
          ),
        ),
      ),
    );
  }
}
