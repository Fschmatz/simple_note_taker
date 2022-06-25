import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:share_handler/share_handler.dart';
import 'package:simple_note_taker/share/share_save_note.dart';
import 'package:simple_note_taker/util/theme.dart';
import 'app.dart';
import 'class/init_data.dart';
import 'class/show_data_argument.dart';

const String homeRoute = "home";
const String showDataRoute = "share";

Future<InitData> init() async {
  String sharedText = "";
  String routeName = homeRoute;
  ShareHandlerPlatform handler = ShareHandlerPlatform.instance;

  InitData loadInitData = InitData('', '');
  String? lastSave = await loadInitData.loadFromPrefs();

  //app not in memory
  SharedMedia? sharedValue = await handler.getInitialSharedMedia();

  if (sharedValue != null && sharedValue.content.toString() != lastSave) {
    sharedText = sharedValue.content.toString();
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

class StartAppRoutes extends StatefulWidget {
  const StartAppRoutes({Key? key, required this.initData}) : super(key: key);

  final InitData initData;

  @override
  _StartAppRoutesState createState() => _StartAppRoutesState();
}

class _StartAppRoutesState extends State<StartAppRoutes> {
  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
  SharedMedia? media;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  //app in memory
  Future<void> initPlatformState() async {
    final handler = ShareHandlerPlatform.instance;
    media = await handler.getInitialSharedMedia();

    handler.sharedMediaStream.listen((SharedMedia media) {
      if (!mounted) return;
      _navKey.currentState!.pushNamed(
        showDataRoute,
        arguments: ShowDataArgument(media.content.toString()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navKey,
      debugShowCheckedModeBanner: false,
      theme: light,
      darkTheme: dark,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case homeRoute:
            return MaterialPageRoute(builder: (_) => const App());
          case showDataRoute:
            {
              if (settings.arguments != null) {
                final args = settings.arguments as ShowDataArgument;
                return MaterialPageRoute(
                    builder: (_) => ShareSaveNote(
                      sharedText: args.sharedText,
                      outsideMemory: false,
                    ));
              } else {
                return MaterialPageRoute(
                    builder: (_) => ShareSaveNote(
                      sharedText: widget.initData.sharedText,
                      outsideMemory: true,
                    ));
              }
            }
        }
        return MaterialPageRoute(builder: (_) => const App());
      },
      initialRoute: widget.initData.routeName,
    );
  }
}