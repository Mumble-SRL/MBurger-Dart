/// Use this class to set a contract as accepted/declined by the  user in the registration/signup.
class MBAuthContractAcceptanceParameter {
  /// The id of the contract
  final String contractId;

  /// If the contract is accepted or not
  final bool accepted;

  MBAuthContractAcceptanceParameter({this.contractId, this.accepted});

  Map<String, dynamic> get representation =>
      {"id": contractId, "accepted": accepted};
}
