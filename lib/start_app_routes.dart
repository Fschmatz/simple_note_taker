import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_handler/share_handler.dart';
import 'package:simple_note_taker/share/save_shared_note.dart';
import 'app.dart';
import 'class/init_data.dart';
import 'class/show_data_argument.dart';
import 'main.dart';

class StartAppRoutes extends StatefulWidget {
  const StartAppRoutes({Key? key, required this.initData}) : super(key: key);

  final InitData initData;

  @override
  State<StartAppRoutes> createState() => _StartAppRoutesState();
}

class _StartAppRoutesState extends State<StartAppRoutes> {
  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
  SharedMedia? media;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    initPlatformState();
  }

  //app in memory
  Future<void> initPlatformState() async {
    final handler = ShareHandlerPlatform.instance;

    handler.sharedMediaStream.listen((SharedMedia media) {
      _navKey.currentState!.pushNamed(
        showDataRoute,
        arguments: ShowDataArgument(media.content.toString()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MaterialApp(
        navigatorKey: _navKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: lightDynamic,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkDynamic,
          useMaterial3: true,
        ),
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
                      builder: (_) => SaveSharedNote(
                            sharedText: args.sharedText,
                          ));
                } else {
                  return MaterialPageRoute(
                      builder: (_) => SaveSharedNote(
                            sharedText: widget.initData.sharedText,
                          ));
                }
              }
          }
          return null;
        },
        initialRoute: widget.initData.routeName,
      );
    });
  }
}
