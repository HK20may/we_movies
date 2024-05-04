import 'package:flutter/material.dart';
import 'package:wework_movies_app/core/helpers/shared_preference/pref_helper.dart';
import 'package:wework_movies_app/we_work_app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.getInstance();
  runApp(const WeWorkApp());
}
