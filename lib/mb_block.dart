import 'package:mburger/mb_section.dart';

/// This class represent a MBurger Block.
class MBBlock {
  /// The id of the block.
  final int id;

  /// The title of the block.
  final String title;

  /// The subtitle of the block.
  final String subtitle;

  /// The order index of the block.
  final int order;

  /// The sections of the block.
  final List<MBSection> sections;

  /// Initializes a `MBBlock` with all its data
  MBBlock({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.order,
    required this.sections,
  });

  /// Initializes a block with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBBlock.fromDictionary(Map<String, dynamic> dictionary) {
    int id = dictionary['id'] as int;
    String title = dictionary['title'] as String;
    String subtitle = dictionary['subtitle'] as String;
    int order = dictionary['order'] as int;

    List<MBSection> sections = [];
    if (dictionary['sections'] != null) {
      List<Map<String, dynamic>> sectionsDictionaries =
          List.castFrom<dynamic, Map<String, dynamic>>(
              dictionary['sections'] as List);
      sections =
          sectionsDictionaries.map((e) => MBSection.fromDictionary(e)).toList();
    }

    return MBBlock(
      id: id,
      title: title,
      subtitle: subtitle,
      order: order,
      sections: sections,
    );
  }
}
