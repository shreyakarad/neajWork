import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';


/// The body of the main Rate my app test widget.
class RateMyAppTestApp extends StatefulWidget {
  /// Creates a new Rate my app test app instance.
  const RateMyAppTestApp();

  @override
  State<StatefulWidget> createState() => RateMyAppTestAppState();
}

/// The body state of the main Rate my app test widget.
class RateMyAppTestAppState extends State<RateMyAppTestApp> {
  /// The widget builder.
  WidgetBuilder builder = buildProgressIndicator;

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Rate my app !'),
      ),
      body: RateMyAppBuilder(
        builder: builder,
        onInitialized: (context, rateMyApp) {
          setState(() => builder = (context) => RateDialogPage(rateMyApp: rateMyApp));
          rateMyApp.conditions.forEach((condition) {
            if (condition is DebuggableCondition) {
              print(condition.valuesAsString); // We iterate through our list of conditions and we print all debuggable ones.
            }
          });
          print('Are all conditions met ? ' + (rateMyApp.shouldOpenDialog ? 'Yes' : 'No'));

          if (rateMyApp.shouldOpenDialog) {
            rateMyApp.showRateDialog(context);
          }
        },
      ),
    ),
  );

  /// Builds the progress indicator, allowing to wait for Rate my app to initialize.
  static Widget buildProgressIndicator(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}



class RateDialogPage extends StatefulWidget {
  final RateMyApp rateMyApp;
  const RateDialogPage({Key key, @required this.rateMyApp}) : super(key: key);
  @override
  _RateDialogPageState createState() => _RateDialogPageState();
}

class _RateDialogPageState extends State<RateDialogPage> {
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(48),
    child: Center(
      child: TextButton(
        child: Text('Rate App'),
        onPressed : () => widget.rateMyApp.showRateDialog(context),
      ),
    ),
  );
}