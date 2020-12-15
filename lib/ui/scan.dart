import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult;
  bool backCamera = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan"),
        actions: <Widget>[
          IconButton(
            icon: backCamera
                ? Icon(Ionicons.ios_reverse_camera)
                : Icon(Icons.camera),
            onPressed: (){
              setState(() {
                backCamera = !backCamera;
                camera = backCamera ? 1 : -1;
              });
            },
          ),
          IconButton(
            icon: Icon(MaterialCommunityIcons.qrcode_scan),
            onPressed: () async {
              ScanResult codeScanner = await BarcodeScanner.scan(
                  options: ScanOptions(
                      useCamera: camera
                  ),
              );
              setState(() {
                qrCodeResult = codeScanner.rawContent;
              });
            },
          ),
        ],
      ),

      body: Center(
        child: Text(
            (qrCodeResult == null ) || (qrCodeResult == "")
                ? "Please scan to show some result"
                : "Result: " + qrCodeResult,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

int camera = 1;
