import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {

  String qrResult = "Scanned data will appear here.";

  Future<void> scanQr() async {
    try{
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR
      );
      if(!mounted) return;
      setState(() {
        qrResult = qrCode.toString();
      });
    }on PlatformException{
      qrResult = "Failed to read QR Code.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Text(qrResult, style: TextStyle(color: Colors.black),),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: scanQr, 
              child: Text("Scan QR Code"))
          ],
        ),
      ),
    );
  }
}