import 'package:flutter/material.dart';
import 'package:mburger/mburger.dart';

void main() {
  MBManager.shared.apiToken = 'd56411e2ffcc547cd11de4bea08aff46b2a201ce';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBurger Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MBurgerExample(),
    );
  }
}

class MBurgerExample extends StatelessWidget {
  const MBurgerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MBurger Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: const Text('Get project'),
              onPressed: () => _getProject(),
            ),
            MaterialButton(
              child: const Text('Get block'),
              onPressed: () => _getBlock(),
            ),
            MaterialButton(
              child: const Text('Get section'),
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
      debugPrint(project.id.toString());
      debugPrint(project.name);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  /// Retrieves all the sections of a block with the id passed
  void _getBlock() async {
    try {
      MBBlock block = await MBManager.shared.getBlock(
        blockId: 4942,
        includeElements: true,
      );

      debugPrint(block.id.toString());
      debugPrint(block.title);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  /// Retrieves a sections with the id passed
  void _getSection() async {
    try {
      MBSection section = await MBManager.shared.getSection(
        sectionId: 348460,
        includeElements: true,
      );

      debugPrint(section.id.toString());
      debugPrint(section.order.toString());
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
