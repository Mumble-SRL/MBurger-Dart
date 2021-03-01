import 'dart:convert';

import 'package:mburger/elements/mb_element.dart';

/// This class represents a MBurger shopify element.
class MBShopifyCollectionElement extends MBElement {
  /// The collections of this element.
  List<MBShopifyCollection> collections;

  /// Initializes a collection element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBShopifyCollectionElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    dynamic valueFromDictionary = dictionary['value'];
    List<Map<String, dynamic>> value;
    if (valueFromDictionary is String) {
      List<dynamic> valueList =
          json.decode(valueFromDictionary) as List<dynamic>;
      value = List<Map<String, dynamic>>.from(valueList);
    } else if (valueFromDictionary is List) {
      value = List<Map<String, dynamic>>.from(valueFromDictionary);
    }

    if (value != null) {
      collections =
          value.map((img) => MBShopifyCollection(dictionary: img)).toList();
    }
  }
}

class MBShopifyCollection {
  /// The id of the shopify collection.
  String collectionId;

  /// The name of the shopify collection.
  String collectionName;

  /// The url of the image of the shopify collection.
  String image;

  /// Initializes an address element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBShopifyCollection({Map<String, dynamic> dictionary}) {
    if (dictionary['id'] is int) {
      int intCollectionId = dictionary['id'] as int;
      collectionId = intCollectionId.toString();
    } else {
      collectionId = dictionary['id'] as String;
    }
    collectionName = dictionary['text'] as String;
    if (dictionary['image'] != null) {
      Map<String, dynamic> imageDict =
          dictionary['image'] as Map<String, dynamic>;
      if (imageDict['src'] != null) {
        image = imageDict['src'] as String;
      }
    }
  }
}
