import 'package:flutter/material.dart';
import 'package:mburger/mburger.dart';

void main() {
  MBManager.shared.apiToken = 'YOUR_API_TOKEN';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBurger Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MBurgerExample(),
    );
  }
}

class MBurgerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MBurger Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text('Get project'),
              onPressed: () => _getProject(),
            ),
            MaterialButton(
              child: Text('Get block'),
              onPressed: () => _getBlock(),
            ),
            MaterialButton(
              child: Text('Get section'),
              onPressed: () => _getSection(),
            )
          ],
        ),
      ),
    );
  }

  /// Retrieves the project connected to the token
  void _getProject() async {
    try {
      MBProject project = await MBManager.shared.getProject();
      print(project);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  /// Retrieves all the sections of a block with the id passed
  void _getBlock() async {
    try {
      MBBlock block = await MBManager.shared.getBlock(
        blockId: 1,
        includeElements: true,
      );

      print(block);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  /// Retrieves a sections with the id passed
  void _getSection() async {
    try {
      MBSection section = await MBManager.shared.getSection(
        sectionId: 1,
        includeElements: true,
      );
      print(section);
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
