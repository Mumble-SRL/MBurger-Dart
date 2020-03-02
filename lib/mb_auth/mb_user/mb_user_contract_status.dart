class MBUserContractStatus {
  int id;
  bool accepted;
  MBUserContractStatus({
    this.id,
    this.accepted,
  });

  MBUserContractStatus.fromDictionary(Map<String, dynamic> dictionary) {
    id = dictionary['id'];
    accepted = dictionary['accepted'];
  }

  Map<String, dynamic> toDictionary() {
    return {'id': id, 'accepted': accepted};
  }
}
