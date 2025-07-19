import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:share_handler/share_handler.dart';
import 'package:simple_note_taker/redux/actions.dart';
import 'package:simple_note_taker/redux/app_state.dart';
import 'package:simple_note_taker/start_app_routes.dart';

import 'class/init_data.dart';

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

final Store<AppState> store = Store<AppState>(
  initialState: AppState.initialState(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitData initData = await init();

  await store.dispatch(LoadNotesAction());

  runApp(
    StoreProvider<AppState>(
      store: store,
      child: EasyDynamicThemeWidget(
        child: StartAppRoutes(
          initData: initData,
        ),
      ),
    ),
  );
}
