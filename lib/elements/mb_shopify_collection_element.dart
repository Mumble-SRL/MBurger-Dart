import 'dart:convert';

import 'package:mburger/elements/mb_element.dart';

/// This class represents a MBurger shopify element.
class MBShopifyCollectionElement extends MBElement {
  /// The collections of this element.
  final List<MBShopifyCollection> collections;

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [collections]: The collections of this element
  MBShopifyCollectionElement._({
    required super.dictionary,
    required this.collections,
  });

  /// Initializes a collection element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBShopifyCollectionElement(
      {required Map<String, dynamic> dictionary}) {
    List<MBShopifyCollection> collections = [];

    dynamic valueFromDictionary = dictionary['value'];
    List<Map<String, dynamic>>? value;
    if (valueFromDictionary is String) {
      if (valueFromDictionary != '') {
        List<dynamic> valueList =
            json.decode(valueFromDictionary) as List<dynamic>;
        value = List<Map<String, dynamic>>.from(valueList);
      }
    } else if (valueFromDictionary is List) {
      value = List<Map<String, dynamic>>.from(valueFromDictionary);
    }

    if (value != null) {
      collections =
          value.map((img) => MBShopifyCollection(dictionary: img)).toList();
    }

    return MBShopifyCollectionElement._(
      dictionary: dictionary,
      collections: collections,
    );
  }
}

class MBShopifyCollection {
  /// The id of the shopify collection.
  final String collectionId;

  /// The name of the shopify collection.
  final String collectionName;

  /// The url of the image of the shopify collection.
  final String? image;

  /// Private constructor to initialize variables from the factory constructor
  MBShopifyCollection._({
    required this.collectionId,
    required this.collectionName,
    required this.image,
  });

  /// Initializes an address element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBShopifyCollection({required Map<String, dynamic> dictionary}) {
    String collectionId = '';
    String collectionName = '';
    String? image;

    if (dictionary['id'] is int) {
      int intCollectionId = dictionary['id'] as int;
      collectionId = intCollectionId.toString();
    } else {
      collectionId = dictionary['id'] as String;
    }

    if (dictionary['text'] is String) {
      collectionName = dictionary['text'] as String;
    }

    if (dictionary['image'] != null) {
      Map<String, dynamic> imageDict =
          dictionary['image'] as Map<String, dynamic>;
      if (imageDict['src'] != null) {
        image = imageDict['src'] as String;
      }
    }
    return MBShopifyCollection._(
      collectionId: collectionId,
      collectionName: collectionName,
      image: image,
    );
  }
}
