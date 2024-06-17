import 'package:flutter/material.dart';

import 'package:waiters_app/app/my_app.dart';
import 'package:waiters_app/app/sl/service_locator.dart' as service_locator;
import 'package:waiters_app/core/services/data_services/sqf_lite_services/sqf_lite_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SqfLiteServices.instance.init();

  service_locator.init();
  await service_locator.sl.allReady();

  runApp(const MyApp());
}
