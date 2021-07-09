import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'mb_user/mb_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../mb_exception.dart';
import '../mb_manager.dart';
import 'mb_auth_contract_acceptance_parameter.dart';

/// The types of social login
enum MBAuthSocialLoginType {
  /// Apple social login
  apple,

  /// Facebook social login
  facebook,

  /// Google social login
  google,
}

/// The main class to handle MBurger authorization
class MBAuth {
  /// Registers a user to MBurger.
  /// - Parameters:
  ///   - [name]: The name of the user.
  ///   - [surname]: The surname of the user.
  ///   - [email]: The email of the user.
  ///   - [password]: The password of the user.
  ///   - [phone]: An optional telephone number.
  ///   - [image]: An optional profile image.
  ///   - [contracts]: If there are contracts in the project the user can accept/decline them and you can tell this to MBurger with this parameter.
  ///   - [data]: Optional additional data.
  /// - Returns a [Future] that completes when the user is registered correctly.
  static Future<void> registerUser(
    String name,
    String surname,
    String email,
    String password, {
    String? phone,
    Uint8List? image,
    List<MBAuthContractAcceptanceParameter>? contracts,
    Map<String, dynamic>? data,
  }) async {
    Map<String, String> parameters = {
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
    };

    if (phone != null) {
      parameters['phone'] = phone;
    }
    if (image != null) {
      parameters['image'] = base64.encode(image);
    }
    if (contracts != null) {
      List<Map<String, dynamic>> contractsArray =
          contracts.map((c) => c.representation).toList();
      parameters['contracts'] = json.encode(contractsArray);
    }
    if (data != null) {
      parameters['data'] = json.encode(data);
    }

    String apiName = 'api/register';

    var uri = Uri.https(MBManager.shared.endpoint, apiName);

    Map<String, String> totalParameters = {};
    totalParameters.addAll(parameters);
    totalParameters.addAll(await MBManager.shared.defaultParameters());

    var requestBody = json.encode(totalParameters);

    Map<String, String> headers =
        await MBManager.shared.headers(contentTypeJson: true);

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: requestBody,
    );

    MBManager.checkResponse(response.body, checkBody: false);
  }

  /// Authenticate a user with email and password.
  /// - Parameters:
  ///   - [email]: The email.
  ///   - [password]: The password.
  /// - Returns a [Future] that completes when the user is authenticated correctly.
  static Future<void> authenticateUser(String email, String password) {
    return _authenticateUserWithParameters({
      'mode': 'email',
      'email': email,
      'password': password,
    });
  }

  /// Authenticate a user with social.
  /// - Parameters:
  ///   - [token]: The social token.
  ///   - [loginType]: The social the user used to authenticate.
  ///   - [name]: Used only when logging with apple, to set the name in MBurger.
  ///   - [surname]: Used only when logging with apple, to set the surname in MBurger.
  ///   - [contracts]: If there are contracts in the project the user can accept/decline them and you can tell this to MBurger with this parameter.
  /// - Returns a [Future] that completes when the user is authenticated correctly.
  static Future<void> authenticateUserWithSocial(
    String token,
    MBAuthSocialLoginType loginType, {
    String? name,
    String? surname,
    List<MBAuthContractAcceptanceParameter>? contracts,
  }) {
    Map<String, String> parameters = {};
    if (loginType == MBAuthSocialLoginType.apple) {
      parameters['mode'] = 'apple';
      parameters['apple_token'] = token;
    } else if (loginType == MBAuthSocialLoginType.facebook) {
      parameters['mode'] = 'facebook';
      parameters['facebook_token'] = token;
    } else if (loginType == MBAuthSocialLoginType.google) {
      parameters['mode'] = 'google';
      parameters['google_token'] = token;
    }
    if (name != null) {
      parameters['name'] = name;
    }
    if (surname != null) {
      parameters['surname'] = surname;
    }
    if (contracts != null) {
      List<Map<String, dynamic>> contractsArray =
          contracts.map((c) => c.representation).toList();
      parameters['contracts'] = json.encode(contractsArray);
    }

    return _authenticateUserWithParameters(parameters);
  }

  static Future<void> _authenticateUserWithParameters(
    Map<String, String> parameters,
  ) async {
    String apiName = 'api/authenticate';

    var uri = Uri.https(MBManager.shared.endpoint, apiName);

    Map<String, String> totalParameters = {};
    totalParameters.addAll(parameters);
    totalParameters.addAll(await MBManager.shared.defaultParameters());

    var requestBody = json.encode(totalParameters);

    Map<String, String> headers =
        await MBManager.shared.headers(contentTypeJson: true);

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: requestBody,
    );

    Map<String, dynamic> body = MBManager.checkResponse(response.body);

    String? token;
    if (body['access_token'] is String) {
      token = body['access_token'] as String;
    }

    if (token == null) {
      throw MBException(statusCode: 1000, message: 'Token can\'t be found');
    }
    await _setUserLoggedIn(token);
  }

  /// Logs out the current user.
  /// - Returns a [Future] that completes when the user is logged out correctly.
  static Future<void> logoutCurrentUser() async {
    String apiName = 'api/logout';

    var uri = Uri.https(MBManager.shared.endpoint, apiName);

    var requestBody = json.encode(await MBManager.shared.defaultParameters());

    Map<String, String> headers =
        await MBManager.shared.headers(contentTypeJson: true);

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: requestBody,
    );

    MBManager.checkResponse(response.body, checkBody: false);

    await _setUserLoggedOut();
  }

  /// Password reset, an email is sent to the user with the instructions to re-set the password.
  /// - Parameters:
  ///   - [email]: The email of the user.
  /// - Returns a [Future] that completes when the api is called with success.
  static Future<void> forgotPassword(String email) async {
    String apiName = 'api/forgot-password';

    var uri = Uri.https(MBManager.shared.endpoint, apiName);

    Map<String, String> apiParameters = {};
    apiParameters['email'] = email;
    apiParameters.addAll(await MBManager.shared.defaultParameters());

    var requestBody = json.encode(apiParameters);

    Map<String, String> headers =
        await MBManager.shared.headers(contentTypeJson: true);

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: requestBody,
    );

    MBManager.checkResponse(response.body, checkBody: false);
  }

  /// Change the password of the current logged in user.
  /// - Parameters:
  ///   - [oldPassword]: The old password of the user.
  ///   - [newPassword]: The new password of the user.
  /// - Returns a [Future] that completes when the api is called with success.
  static Future<void> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    String apiName = 'api/change-password';

    var uri = Uri.https(MBManager.shared.endpoint, apiName);

    Map<String, String> apiParameters = {};
    apiParameters['old_password'] = oldPassword;
    apiParameters['new_password'] = newPassword;
    apiParameters.addAll(await MBManager.shared.defaultParameters());

    var requestBody = json.encode(apiParameters);

    Map<String, String> headers =
        await MBManager.shared.headers(contentTypeJson: true);

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: requestBody,
    );

    MBManager.checkResponse(response.body, checkBody: false);
  }

//region profile

  /// Returns the profile of the current user.
  /// - Returns a [Future] that completes with the profile of the current logged in user.
  static Future<MBUser> getUserProfile() async {
    String apiName = 'api/profile';

    Map<String, String> apiParameters =
        await MBManager.shared.defaultParameters();
    var uri = Uri.https(MBManager.shared.endpoint, apiName, apiParameters);

    Map<String, String> headers = await MBManager.shared.headers();

    http.Response response = await http.get(
      uri,
      headers: headers,
    );

    Map<String, dynamic> body = MBManager.checkResponse(response.body);
    return MBUser.fromDictionary(body);
  }

  /// Updates user information, only data that are passed to this function are changed, the fields not passed will remain untouched.
  /// - Parameters:
  ///   - [name]: The name of the user.
  ///   - [surname]: The surname of the user.
  ///   - [phone]: An optional telephone number.
  ///   - [image]: An optional profile image.
  ///   - [contracts]: If there are contracts in the project the user can accept/decline them and you can tell this to MBurger with this parameter.
  ///   - [data]: Optional additional data.
  /// - Returns a [Future] that completes when the profile is changed correctly.
  static Future<MBUser> updateUser({
    String? name,
    String? surname,
    String? phone,
    Uint8List? image,
    Map<String, dynamic>? data,
    List<MBAuthContractAcceptanceParameter>? contracts,
  }) async {
    String apiName = 'api/profile/update';

    Map<String, String> apiParameters =
        await MBManager.shared.defaultParameters();
    if (name != null) {
      apiParameters['name'] = name;
    }
    if (surname != null) {
      apiParameters['surname'] = surname;
    }
    if (phone != null) {
      apiParameters['phone'] = phone;
    }
    if (image != null) {
      apiParameters['image'] = base64.encode(image);
    }
    if (data != null) {
      apiParameters['data'] = jsonEncode(data);
    }
    if (contracts != null) {
      apiParameters['contracts'] =
          jsonEncode(contracts.map((c) => c.representation).toList());
    }

    var uri = Uri.https(MBManager.shared.endpoint, apiName);

    Map<String, String> headers =
        await MBManager.shared.headers(contentTypeJson: true);

    String requestBody = jsonEncode(apiParameters);

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: requestBody,
    );

    Map<String, dynamic> body = MBManager.checkResponse(response.body);
    return MBUser.fromDictionary(body);
  }

  /// Deletes the profile for the current logged in user.
  /// - Returns a [Future] that completes when the profile is deleted correctly.
  static Future<void> deleteProfile() async {
    String apiName = 'api/profile/delete';

    Map<String, String> apiParameters =
        await MBManager.shared.defaultParameters();
    var uri = Uri.https(MBManager.shared.endpoint, apiName, apiParameters);

    Map<String, String> headers = await MBManager.shared.headers();

    http.Response response = await http.delete(
      uri,
      headers: headers,
    );

    MBManager.checkResponse(response.body, checkBody: false);
    await _setUserLoggedOut();
  }

//region token

  static String _loggedInKey() => 'com.mumble.mburger.userLoggedIn';

  static String _tokenKey() => 'com.mumble.mburger.token';

  static Future<void> _setUserLoggedIn(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey(), true);
    final storage = FlutterSecureStorage();
    await storage.write(key: _tokenKey(), value: token);
  }

  static Future<void> _setUserLoggedOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey(), false);
    final storage = FlutterSecureStorage();
    await storage.delete(key: _tokenKey());
  }

  /// If the user is logged in.
  /// - Returns a [Future] that completes with a bool that represents if the user is logged in.
  static Future<bool> userLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool(_loggedInKey()) ?? false;
    return loggedIn;
  }

  /// The token of the user.
  /// - Returns a [Future] that completes with the user token.
  static Future<String?> userToken() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: _tokenKey());
    return token;
  }

//endregion
}
