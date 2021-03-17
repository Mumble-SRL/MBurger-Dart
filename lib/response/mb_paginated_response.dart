/// This class represents a paginated response.
/// In items there's the actual elements of the response, all other properties are additional information about number of elements returned.
class MBPaginatedResponse<T> {
  /// The starting point of this block of items.
  final int from;

  /// The end point of this block of items.
  final int to;

  /// The total number of items in MBurger.
  final int total;

  /// The items returned by the API.
  final List<T> items;

  /// Initializes a paginated response, with the items and information about pagination.
  MBPaginatedResponse({
    required this.from,
    required this.to,
    required this.total,
    required this.items,
  });
}
