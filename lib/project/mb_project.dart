import 'mb_contract.dart';

class MBProject {
  int id;
  String name;
  List<MBContract> contracts;

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
