import 'package:flutter/material.dart';

import '../screens/qr_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'qr': (_) => const QrScreen(
        qrlink: '',
      ),
};
