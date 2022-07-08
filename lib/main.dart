import 'package:flutter/material.dart';

import './src/app.dart';
import './src/pages/router.dart';

void main(List<String> args) {
  final appRouter = AppRouter();
  runApp(App(appRouter: appRouter));
}
