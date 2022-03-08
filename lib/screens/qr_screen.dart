import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatefulWidget {
  final String qrlink;

  const QrScreen({Key? key, required this.qrlink}) : super(key: key);
  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  @override
  Widget build(BuildContext context) {
    const message =
        // ignore: lines_longer_than_80_chars
        'Hey this is a QR code. Change this value in the main_screen.dart file.';

    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: QrImage(
                    data: widget.qrlink, version: QrVersions.auto, size: 200.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                  .copyWith(bottom: 40),
              child: const Text(message),
            ),
          ],
        ),
      ),
    );
  }
}
