class MBAuthContractAcceptanceParameter {
  final String contractId;
  final bool accepted;

  MBAuthContractAcceptanceParameter({this.contractId, this.accepted});

  Map<String, dynamic> get representation =>
      {"id": contractId, "accepted": accepted};
}
