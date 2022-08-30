import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:share_handler/share_handler.dart';
import 'package:simple_note_taker/share/save_shared_note.dart';
import 'package:simple_note_taker/start_app_routes.dart';
import 'package:simple_note_taker/util/theme.dart';
import 'app.dart';
import 'class/init_data.dart';
import 'class/show_data_argument.dart';

const String homeRoute = "home";
const String showDataRoute = "share";

Future<InitData> init() async {
  String sharedText = "";
  String routeName = homeRoute;
  final handler = ShareHandlerPlatform.instance;
  SharedMedia? sharedValue = await handler.getInitialSharedMedia();

  if (sharedValue != null) {
    sharedText = sharedValue.content!;
    routeName = showDataRoute;
    handler.resetInitialSharedMedia();
  }

  return InitData(sharedText, routeName);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitData initData = await init();

  runApp(
    EasyDynamicThemeWidget(
      child: StartAppRoutes(
        initData: initData,
      ),
    ),
  );
}
