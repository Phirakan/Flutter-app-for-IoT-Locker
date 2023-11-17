import 'package:flutter/material.dart';
import 'package:flutterprojectiot/screen/home.dart';

class StartScreen extends StatelessWidget {
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
            const Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(223, 18, 73, 255),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/locker.jpg'), // รูปภาพพื้นหลัง
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(
                  0.4), // สีดำที่ใช้ในการจางรูปภาพ (เปลี่ยนค่าตรงนี้ตามความต้องการ)
              BlendMode.dstATop,
            ),
          ),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 232, 237, 255),
              Color.fromARGB(255, 36, 87, 255)
            ], // กำหนดสีใน gradient
            begin: Alignment.topLeft, // จุดเริ่ม gradient
            end: Alignment.bottomRight, // จุดสิ้นสุด gradient
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/img/psuLogo.png",
                    width: 150,
                    height: 150,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40), // กำหนด padding ด้านบน
                    child: Image.asset(
                      "assets/img/Logo.png",
                      width: 300,
                      height: 300,
                    ),
                  ),
                  SizedBox(
                      height:
                          20), // Add a SizedBox to create space between the button and the text
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '© 2023 FlutterProjectIoT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment
                        .bottomCenter, // กำหนดตำแหน่งของปุ่มด้วย Alignment
                    child: ElevatedButton(
                      child: Text(
                        'เริ่มต้นใช้งาน',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
