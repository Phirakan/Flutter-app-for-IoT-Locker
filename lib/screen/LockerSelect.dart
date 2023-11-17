import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'LockerDetail.dart';


class LockerDataScreen extends StatefulWidget {
  @override
  _LockerDataScreenState createState() => _LockerDataScreenState();
}

class _LockerDataScreenState extends State<LockerDataScreen> {
  List<Map<String, dynamic>> lockerData = [];
  int selectedLockerIndex = -1; // ค่าเริ่มต้นเลือกตู้เป็น -1
  bool isConfirmationPressed = false; // Track if the button is pressed

  Future<void> fetchLockerData() async {
    final response = await http.get(Uri.parse('https://mosuuuu.tech/lockerprox/api/locker.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        lockerData = data.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('การดึงข้อมูลล้มเหลว');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLockerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locker'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
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
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'กรุณาเลือกตู้ที่ต้องการ',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: lockerData.length,
                  itemBuilder: (context, index) {
                   
                    Color statusColor = Colors.green;

                    if (lockerData[index]['status_id'] == 0) {
                    
                    } else if (lockerData[index]['status_id'] == 1) {
                     
                      statusColor = selectedLockerIndex == index && isConfirmationPressed
                          ? Colors.red
                          : Colors.green;
                    }

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedLockerIndex == index) {
                            selectedLockerIndex = -1;
                          } else {
                            selectedLockerIndex = index;
                          }
                        });
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock,
                              size: 40,
                              color: statusColor,
                            ),
                            SizedBox(height: 8),
                            Text('ตู้เก็บของที่: ${lockerData[index]['lock_id']}'),
                            
                            if (selectedLockerIndex == index)
                              Text('เลือกตู้ที่ ${lockerData[index]['lock_id']}'),
                             
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (selectedLockerIndex != -1)
                 ElevatedButton(
  onPressed: () {
    if (selectedLockerIndex != -1) {
      // Fetch the selected locker's data
      final selectedLockerData = lockerData[selectedLockerIndex];

      // Navigate to LockerDetail screen with the selected locker's data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LockerDetail (lockerData: selectedLockerData),
        ),  //The named parameter 'lockerdata' isn't defind
      );
    }
  },
  child: Text('ยืนยันการเลือกตู้'),
),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
