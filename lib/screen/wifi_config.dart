import 'package:esp_smartconfig/esp_smartconfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class WiFiConfigPage extends StatefulWidget {
  @override
  _WiFiConfigPageState createState() => _WiFiConfigPageState();
}

class _WiFiConfigPageState extends State<WiFiConfigPage> {
  // สร้าง TextEditingController สำหรับข้อมูล WiFi
  TextEditingController textWifiNameController = TextEditingController();
  TextEditingController textWifiBSSIDController = TextEditingController();
  TextEditingController textWifiPasswordController = TextEditingController();

  NetworkInfo networkInfo = NetworkInfo();
  String? wifiName, wifiBSSID;
  bool startProvistioning = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Provisioner provisioner;

  @override
  void initState() {
    super.initState();

    //permission
    permissionHandler();

    //network info
    getNetworkInfo();
  }

  permissionHandler() async {
    await Permission.location.status.then((value) async {
      if (!value.isGranted) {
        await Permission.location.request().then((value) {
          //network info
          getNetworkInfo();
        });
      }
    });
  }

  getNetworkInfo() async {
    //get wifi name
    wifiName = await networkInfo.getWifiName();
    //get wifi bssid
    wifiBSSID = await networkInfo.getWifiBSSID();

    String twpWifiName = '$wifiName';
    int len = twpWifiName.length;
    wifiName = twpWifiName.substring(1, len - 1);

    print('wifi name = $wifiName, wifi bssid = $wifiBSSID');

    textWifiNameController.text = '$wifiName';
    textWifiBSSIDController.text = '$wifiBSSID';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Config WiFi'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // สร้าง TextFormField สำหรับ WiFi Name
              TextFormField(
                controller: textWifiNameController,
                decoration: InputDecoration(labelText: 'WiFi Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอก WiFi Name';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              // สร้าง TextFormField สำหรับ BSSID
              TextFormField(
                controller: textWifiBSSIDController,
                decoration: InputDecoration(labelText: 'BSSID'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอก BSSID';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              // สร้าง TextFormField สำหรับ WiFi Password
              TextFormField(
                controller: textWifiPasswordController,
                decoration: InputDecoration(labelText: 'WiFi Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอก WiFi Password';
                  }
                  return null;
                },
                obscureText: true, // ซ่อนข้อมูล
              ),

              SizedBox(height: 16),

              // เพิ่มปุ่มเพื่อบันทึกข้อมูล WiFi
              Visibility(
                visible: !startProvistioning,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        //start listen wifi  provistioning
                        provisioner =Provisioner.espTouch();

                        //Listen
                        provisioner.listen(
                          (response){
                            // show response
                            print(response.bssidText);
                          },
                          );

                         try{
                          await provisioner.start(ProvisioningRequest.fromStrings(
                            ssid: textWifiNameController.text, 
                            bssid: textWifiBSSIDController.text,
                            password: textWifiPasswordController.text,
                            ));

                            await Future.delayed(Duration(seconds: 10));
                         } catch(e, s){
                            print('{e}');
                         }


                        //set state
                        setState(() {
                          startProvistioning = true;
                        });
                      }
                    },
                    child: Text('start'),
                  ),
                ),
              ),

              //stop
              Visibility(
                visible: startProvistioning,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      //stop listen wifi  provistioning
                      setState(() {
                        startProvistioning = false;
                      });
                    },
                    child: Text('stop'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WiFiConfigPage(),
  ));
}
