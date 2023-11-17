import 'package:flutter/material.dart';
import 'dart:async'; // นำเข้าไฟล์ dart:async
import 'LockerControl.dart'; // ตรวจสอบว่าคุณได้นำเข้าไฟล์นี้อย่างถูกต้อง

class LockerDetail extends StatefulWidget {
  final Map<String, dynamic> lockerData;

  LockerDetail({Key? key, required this.lockerData}) : super(key: key);

  @override
  _LockerDetailState createState() => _LockerDetailState();
}

class _LockerDetailState extends State<LockerDetail> {
  bool isBooked = false;
  bool isUsed = false;
  Timer? _timer;
  int _start = 15 * 60; // 15 นาที = 900 วินาที

 void startTimer() {
  const oneSec = Duration(seconds: 1);
  _timer = Timer.periodic(
    oneSec,
    (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          isUsed = false;
          isBooked = false;
          _start = 15 * 60;
        });
      } else {
        setState(() {
          _start--;
        });

        if (_start == 300) { // เมื่อเหลือ 5 นาที
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("เตือน"),
                content: Text("เวลาใช้งานล็อคเกอร์เหลือ 5 นาที"),
                actions: <Widget>[
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิดป๊อปอัพ
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    },
  );
}



  void resetTimer() {
    setState(() {
      _timer?.cancel(); // ยกเลิก Timer ปัจจุบัน
      _start = 15 * 60; // รีเซ็ตเวลากลับเป็น 15 นาที
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locker Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Locker ID: ${widget.lockerData['lock_id']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Icon(
              Icons.lock,
              size: 40,
              color: isUsed ? Colors.red : (isBooked ? Colors.orange : Colors.green),
            ),
            SizedBox(height: 10),
            if (!isBooked && !isUsed) // แสดงปุ่มจองหากยังไม่ถูกจองและยังไม่ถูกใช้งาน
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isBooked = true; // เปลี่ยนสถานะเป็น 'จองแล้ว'
                  });
                },
                child: Text('จอง'),
              ),
            if (isBooked && !isUsed) // แสดงปุ่มยกเลิกจองหากถูกจองแล้ว
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isBooked = false; // ยกเลิกการจอง
                    resetTimer(); // รีเซ็ต Timer
                  });
                },
                child: Text('ยกเลิกจอง'),
              ),
            if (isBooked && !isUsed) // แสดงปุ่มใช้งานหากถูกจองแล้ว
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isUsed = true; // เปลี่ยนสถานะเป็น 'ใช้งานแล้ว'
                    startTimer(); // เริ่มต้นนับถอยหลัง
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LockerDataScreen()),
                  );
                },
                child: Text('ใช้งาน Locker'),
              ),
            if (isUsed) // แสดงปุ่มยกเลิกการใช้งานหากตู้กำลังถูกใช้งาน
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isUsed = false; // ยกเลิกการใช้งาน
                    resetTimer(); // รีเซ็ต Timer
                  });
                },
                child: Text('ยกเลิกการใช้งาน'),
              ),
            if (isUsed) // แสดงเวลานับถอยหลัง
              Text("เวลาที่เหลือ: ${(_start ~/ 60).toString().padLeft(2, '0')}:${(_start % 60).toString().padLeft(2, '0')}"),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // ทำลาย Timer เมื่อไม่ใช้งาน
    super.dispose();
  }
}
