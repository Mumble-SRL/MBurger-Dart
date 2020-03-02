class MBContract {
  int id;

  String name;
  String link;
  String text;
  bool active;

  MBContract.fromDictionary(Map<String, dynamic> dictionary) {
    id = dictionary['id'];
    name = dictionary['name'];
    link = dictionary['link'];
    text = dictionary['text'];
    active = dictionary['active'];
  }
}
