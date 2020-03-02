class MBPaginatedResponse<T> {
  final int from;
  final int to;
  final int total;

  final List<T> items;

  MBPaginatedResponse({
    this.from,
    this.to,
    this.total,
    this.items,
  });
}
