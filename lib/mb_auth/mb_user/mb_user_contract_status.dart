/// The status of a contract, accepted or declined by a user
class MBUserContractStatus {
  /// The id of the contract
  final int id;

  /// If the contract has been accepted or declined
  final bool accepted;

  MBUserContractStatus({
    required this.id,
    required this.accepted,
  });

  factory MBUserContractStatus.fromDictionary(Map<String, dynamic> dictionary) {
    int id = dictionary['id'] is int ? dictionary['id'] as int : 0;
    bool accepted =
        dictionary['accepted'] is bool ? dictionary['accepted'] as bool : false;
    return MBUserContractStatus(
      id: id,
      accepted: accepted,
    );
  }

  Map<String, dynamic> toDictionary() {
    return {'id': id, 'accepted': accepted};
  }
}
