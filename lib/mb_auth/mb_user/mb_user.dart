import 'mb_user_contract_status.dart';

/// The type of authentication used by the user
enum MBUserAuthMode {
  /// Email authentication
  email,
  /// Facebook authentication
  facebook,
  /// Google authentication
  google,
  /// Apple authentication
  apple,
  /// Shopify authentication
  shopify,
}

/// An MBurger user
class MBUser {
  /// The id of the user
  int id;

  /// The name of the user
  String name;
  /// The surname of the user
  String surname;
  /// The email of the user
  String email;
  /// The phone of the user
  String phone;

  /// The url of the profile image
  String imageUrl;

  /// Additional data for this user
  Map<String, dynamic> data;

  /// Contracts associated with the user
  List<MBUserContractStatus> contracts;

  /// The auth mode used to login
  MBUserAuthMode authMode;

  MBUser({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.phone,
    this.imageUrl,
    this.data,
    this.contracts,
    this.authMode,
  });

  /// Initializes a user from the dictionary returned by the api
  MBUser.fromDictionary(Map<String, dynamic> dictionary) {
    id = dictionary['id'] as int;
    name = dictionary['name'] as String;
    surname = dictionary['surname'] as String;
    email = dictionary['email'] as String;
    phone = dictionary['phone'] as String;
    imageUrl = dictionary['image'] as String;

    if (dictionary['contracts'] != null) {
      List<Map<String, dynamic>> contractsArray =
          List.from(dictionary['contracts'] as List);
      contracts = contractsArray
          .map((d) => MBUserContractStatus.fromDictionary(d))
          .toList();
    }

    authMode = authModeFromString(dictionary["auth_mode"] as String);

    if (dictionary['data'] != null) {
      if (dictionary['data'] is Map<String, dynamic>) {
        data = dictionary['data'] as Map<String, dynamic>;
      }
    }
  }

  /// Converts this user to a dictionary
  Map<String, dynamic> toDictionary() {
    Map<String, dynamic> dictionary = {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'phone': phone,
      'image': imageUrl,
      'auth_mode': authModeToString(authMode),
    };

    if (contracts != null) {
      dictionary['contracts'] = contracts.map((c) => c.toDictionary()).toList();
    }
    return dictionary;
  }

  /// Generates a MBUserAuthMode from the string returned by the api
  MBUserAuthMode authModeFromString(String authMode) {
    if (authMode == null) {
      return null;
    }
    if (authMode == 'email') {
      return MBUserAuthMode.email;
    } else if (authMode == 'facebook') {
      return MBUserAuthMode.facebook;
    } else if (authMode == 'google') {
      return MBUserAuthMode.google;
    } else if (authMode == 'apple') {
      return MBUserAuthMode.apple;
    } else if (authMode == 'shopify') {
      return MBUserAuthMode.shopify;
    }

    return MBUserAuthMode.email;
  }

  /// Generates a string from a MBUserAuthMode
  String authModeToString(MBUserAuthMode authMode) {
    if (authMode == null) {
      return null;
    }
    if (authMode == MBUserAuthMode.email) {
      return 'email';
    } else if (authMode == MBUserAuthMode.facebook) {
      return 'facebook';
    } else if (authMode == MBUserAuthMode.google) {
      return 'google';
    } else if (authMode == MBUserAuthMode.apple) {
      return 'apple';
    } else if (authMode == MBUserAuthMode.shopify) {
      return 'shopify';
    }
    return 'email';
  }
}
