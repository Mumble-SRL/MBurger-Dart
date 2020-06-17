import 'mb_contract.dart';

class MBProject {
  int id;
  String name;
  List<MBContract> contracts;

  MBProject.fromDictionary(Map<String, dynamic> dictionary) {
    id = dictionary['id'];
    name = dictionary['name'];
    if (dictionary['contracts'] != null) {
      List<Map<String, dynamic>> contractsList =
          List<Map<String, dynamic>>.from(dictionary['contracts']);
      contracts =
          contractsList.map((c) => MBContract.fromDictionary(c)).toList();
    }
  }
}
