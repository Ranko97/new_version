import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Custom Title',
        dialogText: 'Custom Text',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Instantiate NewVersion manager object (Using GCP Console app as example)
                  final newVersion = NewVersion(
                      // iOSId: 'com.flexyremit.flexy',
                      // androidId: 'com.flexyremit.flexy',
                      );

                  // You can let the plugin handle fetching the status and showing a dialog,
                  // or you can fetch the status and display your own dialog, or no dialog.
                  const simpleBehavior = true;

                  if (simpleBehavior) {
                    basicStatusCheck(newVersion);
                  } else {
                    advancedStatusCheck(newVersion);
                  }
                },
                child: Text("Example App"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
