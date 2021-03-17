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
  _getProject() async {
    MBProject project = await MBManager.shared.getProject().catchError(
      (error) {
        print(error);
      },
    );
    print(project);
  }

  /// Retrieves all the sections of a block with the id passed
  _getBlock() async {
    MBBlock block = await MBManager.shared
        .getBlock(
      blockId: 1,
      includeElements: true,
    )
        .catchError(
      (error) {
        print(error);
      },
    );
    print(block);
  }

  /// Retrieves a sections with the id passed
  _getSection() async {
    MBSection section = await MBManager.shared
        .getSection(
      sectionId: 1,
      includeElements: true,
    )
        .catchError(
      (error) {
        print(error);
      },
    );
    print(section);
  }
}
