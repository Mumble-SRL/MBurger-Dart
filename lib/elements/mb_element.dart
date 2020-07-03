import 'package:mburger/elements/mb_date_element.dart';
import 'package:mburger/elements/mb_dropdown_element.dart';
import 'package:mburger/elements/mb_media_element.dart';
import 'package:mburger/elements/mb_relation_element.dart';

import 'mb_color_element.dart';
import 'mb_poll_element.dart';

import 'mb_address_element.dart';
import 'mb_checkbox_element.dart';
import 'mb_general_element.dart';
import 'mb_images_element.dart';
import 'mb_text_element.dart';

enum MBElementType {
  undefined,
  text,
  images,
  media,
  checkbox,
  date,
  address,
  dropdown,
  poll,
  markdown,
  relation,
  color,
}

abstract class MBElement {
  int order;
  int id;
  MBElementType type;

  MBElement({Map<String, dynamic> dictionary}) {
    id = dictionary['id'] as int;
    order = dictionary['order'] as int;
    type = MBElementsUtilities.elementTypeFromString(dictionary['type'] as String);
  }
}

class MBElementsUtilities {
  static MBElementType elementTypeFromString(String string) {
    switch (string.toLowerCase()) {
      case 'text':
      case 'textarea':
        return MBElementType.text;
        break;
      case 'image':
        return MBElementType.images;
        break;
      case 'audio':
      case 'video':
      case 'document':
      case 'file':
      case 'media':
        return MBElementType.media;
        break;
      case 'checkbox':
        return MBElementType.checkbox;
        break;
      case 'datetime':
        return MBElementType.date;
        break;
      case 'address':
        return MBElementType.address;
        break;
      case 'dropdown':
        return MBElementType.dropdown;
        break;
      case 'poll':
        return MBElementType.poll;
        break;
      case 'markdown':
        return MBElementType.markdown;
        break;
      case 'relation':
        return MBElementType.relation;
        break;
      case 'color':
        return MBElementType.color;
        break;
      default:
        return MBElementType.undefined;
    }
  }

  static MBElement elementFromDictionary(Map<String, dynamic> dictionary) {
    String typeString = dictionary['type'] as String;
    MBElementType type = MBElementsUtilities.elementTypeFromString(typeString);
    switch (type) {
      case MBElementType.text:
        return MBTextElement(dictionary: dictionary);
        break;
      case MBElementType.images:
        return MBImagesElement(dictionary: dictionary);
        break;
      case MBElementType.checkbox:
        return MBCheckboxElement(dictionary: dictionary);
        break;
      case MBElementType.address:
        return MBAddressElement(dictionary: dictionary);
        break;
      case MBElementType.poll:
        return MBPollElement(dictionary: dictionary);
        break;
      case MBElementType.dropdown:
        return MBDropdownElement(dictionary: dictionary);
        break;
      case MBElementType.media:
        return MBMediaElement(dictionary: dictionary);
        break;
      case MBElementType.date:
        return MBDateElement(dictionary: dictionary);
        break;
      case MBElementType.relation:
        return MBRelationElement(dictionary: dictionary);
        break;
      case MBElementType.color:
        return MBColorElement(dictionary: dictionary);
        break;
      default:
        return MBGeneralElement(dictionary: dictionary);
        break;
    }
  }
}
