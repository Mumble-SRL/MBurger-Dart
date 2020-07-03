import 'mb_contract.dart';

/// Represents a MBurger project.
class MBProject {
  /// The id of the project.
  int id;

  /// The name of the project.
  String name;

  /// The legal contracts of the project.
  List<MBContract> contracts;

  /// Initializes a project with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBProject.fromDictionary(Map<String, dynamic> dictionary) {
    id = dictionary['id'] as int;
    name = dictionary['name'] as String;
    if (dictionary['contracts'] != null) {
      List<Map<String, dynamic>> contractsList =
          List<Map<String, dynamic>>.from(dictionary['contracts'] as List);
      contracts =
          contractsList.map((c) => MBContract.fromDictionary(c)).toList();
    }
  }
}
