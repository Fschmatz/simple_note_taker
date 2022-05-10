import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:simple_note_taker/share/share_save_note.dart';
import 'package:simple_note_taker/util/theme.dart';
import 'app.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'class/init_data.dart';
import 'class/show_data_argument.dart';

const String homeRoute = "home";
const String shareRoute = "share";

Future<InitData> init() async {
  String sharedText = "";
  String routeName = homeRoute;
  String? sharedValue = await ReceiveSharingIntent.getInitialText();
  if (sharedValue != null) {
    sharedText = sharedValue;
    routeName = shareRoute;
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
  final _navKey = GlobalKey<NavigatorState>();
  late StreamSubscription _intentDataStreamSubscription;

  @override
  void initState() {
    super.initState();
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
          _navKey.currentState!.pushNamed(
            shareRoute,
            arguments: ShowDataArgument(value),
          );
        });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
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
          case shareRoute:
            {
              if (settings.arguments != null) {
                final args = settings.arguments as ShowDataArgument;
                return MaterialPageRoute(
                    builder: (_) => ShareSaveNote(
                      sharedText: args.sharedText,
                    ));
              } else {
                return MaterialPageRoute(
                    builder: (_) => ShareSaveNote(
                      sharedText: widget.initData.sharedText,
                    ));
              }
            }
        }
      },
      initialRoute: widget.initData.routeName,
    );
  }
}