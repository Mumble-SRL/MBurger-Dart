import 'mb_user_contract_status.dart';

enum MBUserAuthMode { email, facebook, google, apple, shopify }

class MBUser {
  int id;

  String name;
  String surname;
  String email;
  String phone;
  String imageUrl;
  Map<String, dynamic> data;

  List<MBUserContractStatus> contracts;

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
