class MBUserContractStatus {
  int id;
  bool accepted;
  MBUserContractStatus({
    this.id,
    this.accepted,
  });

  MBUserContractStatus.fromDictionary(Map<String, dynamic> dictionary) {
    id = dictionary['id'] as int;
    accepted = dictionary['accepted'] as bool;
  }

  Map<String, dynamic> toDictionary() {
    return {'id': id, 'accepted': accepted};
  }
}
