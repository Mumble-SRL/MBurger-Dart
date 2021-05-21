import 'mb_contract.dart';

/// Represents a MBurger project.
class MBProject {
  /// The id of the project.
  final int id;

  /// The name of the project.
  final String name;

  /// The legal contracts of the project.
  final List<MBContract>? contracts;

  /// Initializes a `MBProject` with all its variables
  MBProject({
    required this.id,
    required this.name,
    required this.contracts,
  });

  /// Initializes a project with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBProject.fromDictionary(Map<String, dynamic> dictionary) {
    int id = dictionary['id'] as int;
    String name = dictionary['name'] as String;
    List<MBContract>? contracts;
    if (dictionary['contracts'] != null) {
      List<Map<String, dynamic>> contractsList =
          List<Map<String, dynamic>>.from(dictionary['contracts'] as List);
      contracts =
          contractsList.map((c) => MBContract.fromDictionary(c)).toList();
    }
    return MBProject(
      id: id,
      name: name,
      contracts: contracts,
    );
  }
}
