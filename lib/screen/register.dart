import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _num_password = TextEditingController();

  Future register(
      String username, String pass, String phone, String numpass) async {
    try {
      String url = "https://mosuuuu.tech/lockerprox/api/register.php";

      final response = await http.post(Uri.parse(url), body: {
        "username": username,
        "password": pass,
        "phone": phone,
        "num_password": numpass,
      });
      var data = json.decode(response.body);
      print('data ==============>' + data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สมัครสมาชิก'),
      ),
       body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/locker.jpg'), // รูปภาพพื้นหลัง
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), // สีดำที่ใช้ในการจางรูปภาพ
              BlendMode.dstATop,
            ),
          ),
        ),
       child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _username,
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'กรุณากรอกชื่อผู้ใช้';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _password,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'กรุณากรอกรหัสผ่าน';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    TextFormField(
                      controller: _confirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        } else if (val != _password.text) {
                          return 'Password not match';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    TextFormField(
                      controller: _phoneNumber,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'กรุณากรอกหมายเลขโทรศัพท์';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _num_password,
                      decoration: InputDecoration(
                        labelText: 'Key Password',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          register(
                            _username.text.trim(),
                            _password.text.trim(),
                            _phoneNumber.text.trim(),
                            _num_password.text.trim(),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 0, 0),
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
         height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
