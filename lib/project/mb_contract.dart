class MBContract {
  int id;

  String name;
  String link;
  String text;
  bool active;

  MBContract.fromDictionary(Map<String, dynamic> dictionary) {
    id = dictionary['id'] as int;
    name = dictionary['name'] as String;
    link = dictionary['link'] as String;
    text = dictionary['text'] as String;
    active = dictionary['active'] as bool;
  }
}
