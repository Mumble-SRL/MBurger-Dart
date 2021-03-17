import 'package:mburger/elements/mb_date_element.dart';
import 'package:mburger/elements/mb_dropdown_element.dart';
import 'package:mburger/elements/mb_markdown_element.dart';
import 'package:mburger/elements/mb_media_element.dart';
import 'package:mburger/elements/mb_relation_element.dart';
import 'package:mburger/elements/mb_shopify_collection_element.dart';

import 'mb_color_element.dart';
import 'mb_poll_element.dart';

import 'mb_address_element.dart';
import 'mb_checkbox_element.dart';
import 'mb_general_element.dart';
import 'mb_images_element.dart';
import 'mb_text_element.dart';

/// The type of elements.
enum MBElementType {
  /// Used when the type of the element can't be defined.
  undefined,

  /// A text element.
  text,

  /// An image element.
  images,

  /// A general media element.
  media,

  /// A checkbox element.
  checkbox,

  /// A date element.
  date,

  /// An address element.
  address,

  /// A dropdown element.
  dropdown,

  /// A poll element.
  poll,

  /// A markdown element.
  markdown,

  /// A relation element.
  relation,

  /// A color element.
  color,

  /// An element representing a shopify collection.
  shopifyCollection,
}

/// This class represents the base class for all MBurger elements. All the specialized elements are subclasses of this class.
abstract class MBElement {
  /// The id of the element.
  final int id;

  /// The type of the element.
  final MBElementType type;

  /// The order of the element.
  final int order;

  /// Initializes the element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBElement({required Map<String, dynamic> dictionary})
      : id = dictionary['id'] as int,
        order = dictionary['order'] as int,
        type = MBElementsUtilities.elementTypeFromString(
            dictionary['type'] as String);
}

/// Utility class for elements
class MBElementsUtilities {
  /// Returns the [MBElementType] from its [String] representation.
  /// - Parameters:
  ///   - [string]: the string representation of the element type.
  static MBElementType elementTypeFromString(String string) {
    switch (string.toLowerCase()) {
      case 'text':
      case 'textarea':
        return MBElementType.text;
      case 'image':
        return MBElementType.images;
      case 'audio':
      case 'video':
      case 'document':
      case 'file':
      case 'media':
        return MBElementType.media;
      case 'checkbox':
        return MBElementType.checkbox;
      case 'datetime':
        return MBElementType.date;
      case 'address':
        return MBElementType.address;
      case 'dropdown':
        return MBElementType.dropdown;
      case 'poll':
        return MBElementType.poll;
      case 'markdown':
        return MBElementType.markdown;
      case 'relation':
        return MBElementType.relation;
      case 'color':
        return MBElementType.color;
      case 'shopify_collection':
        return MBElementType.shopifyCollection;
      default:
        return MBElementType.undefined;
    }
  }

  /// Returns the specialized [MBElement] from the dictionary returned by the API.
  /// - Parameters:
  ///   - [dictionary]: the dictionary from the API.
  /// - Returns: the specific [MBElement] type or a [MBGeneralElement].
  static MBElement elementFromDictionary(Map<String, dynamic> dictionary) {
    String typeString = dictionary['type'] as String;
    MBElementType type = MBElementsUtilities.elementTypeFromString(typeString);
    switch (type) {
      case MBElementType.text:
        return MBTextElement(dictionary: dictionary);
      case MBElementType.images:
        return MBImagesElement(dictionary: dictionary);
      case MBElementType.checkbox:
        return MBCheckboxElement(dictionary: dictionary);
      case MBElementType.address:
        return MBAddressElement(dictionary: dictionary);
      case MBElementType.poll:
        return MBPollElement(dictionary: dictionary);
      case MBElementType.markdown:
        return MBMarkdownElement(dictionary: dictionary);
      case MBElementType.dropdown:
        return MBDropdownElement(dictionary: dictionary);
      case MBElementType.media:
        return MBMediaElement(dictionary: dictionary);
      case MBElementType.date:
        return MBDateElement(dictionary: dictionary);
      case MBElementType.relation:
        return MBRelationElement(dictionary: dictionary);
      case MBElementType.color:
        return MBColorElement(dictionary: dictionary);
      case MBElementType.shopifyCollection:
        return MBShopifyCollectionElement(dictionary: dictionary);
      default:
        return MBGeneralElement(dictionary: dictionary);
    }
  }
}
