import 'package:mburger/mb_section.dart';

/// This class represent a MBurger Block.
class MBBlock {
  /// The id of the block.
  int id;

  /// The title of the block.
  String title;

  /// The subtitle of the block.
  String subtitle;

  /// The order index of the block.
  int order;

  /// The sections of the block.
  List<MBSection> sections;

  /// Initializes a block with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBBlock.fromDictionary(Map<String, dynamic> dictionary) {
    id = dictionary['id'] as int;
    title = dictionary['title'] as String;
    subtitle = dictionary['subtitle'] as String;
    order = dictionary['order'] as int;

    if (dictionary['sections'] != null) {
      List<Map<String, dynamic>> sectionsDictionaries =
          List.castFrom<dynamic, Map<String, dynamic>>(
              dictionary['sections'] as List);
      this.sections =
          sectionsDictionaries.map((e) => MBSection.fromDictionary(e)).toList();
    }
  }
}
