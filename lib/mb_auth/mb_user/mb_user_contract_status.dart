/// The status of a contract, accepted or declined by a user
class MBUserContractStatus {
  /// The id of the contract
  int id;

  /// If the contract has been accepted or declined
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
