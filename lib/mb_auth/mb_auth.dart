import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'mb_user/mb_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../mb_exception.dart';
import '../mb_manager.dart';
import 'mb_auth_contract_acceptance_parameter.dart';

enum MBAuthSocialLoginType { apple, facebook, google }

class MBAuth {
  static Future<void> registerUser(
    String name,
    String surname,
    String email,
    String password, {
    String phone,
    Uint8List image,
    List<MBAuthContractAcceptanceParameter> contracts,
    Map<String, dynamic> data,
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

    var requestBody = json.encode(parameters);

    Map<String, String> headers =
        await MBManager.shared.headers(contentTypeJson: true);

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: requestBody,
    );

    MBManager.checkResponse(response.body, checkBody: false);
  }

  static Future<void> authenticateUser(String email, String password) {
    return authenticateUserWithParameters({
      'mode': 'email',
      'email': email,
      'password': password,
    });
  }

  static Future<void> authenticateUserWithSocial(
    String token,
    MBAuthSocialLoginType loginType, {
    List<MBAuthContractAcceptanceParameter> contracts,
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

    if (contracts != null) {
      List<Map<String, dynamic>> contractsArray =
          contracts.map((c) => c.representation).toList();
      parameters['contracts'] = json.encode(contractsArray);
    }

    return authenticateUserWithParameters(parameters);
  }

  static Future<void> authenticateUserWithParameters(
      Map<String, String> parameters) async {
    String apiName = 'api/authenticate';

    var uri = Uri.https(MBManager.shared.endpoint, apiName);

    Map<String, String> totalParameters = {};
    totalParameters.addAll(parameters);
    totalParameters.addAll(await MBManager.shared.defaultParameters());

    var requestBody = json.encode(parameters);

    Map<String, String> headers =
        await MBManager.shared.headers(contentTypeJson: true);

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: requestBody,
    );

    Map<String, dynamic> body = MBManager.checkResponse(response.body);

    String token = body['access_token'] as String;

    if (token == null) {
      throw MBException('Token can\'t be found');
    }
    await _setUserLoggedIn(token);
  }

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

  static Future<MBUser> updateUser({
    String name,
    String surname,
    String phone,
    Uint8List image,
    Map<String, dynamic> data,
    List<MBAuthContractAcceptanceParameter> contracts,
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

  static String _logedInKey() => 'com.mumble.mburger.userLoggedIn';
  static String _tokenKey() => 'com.mumble.mburger.token';

  static Future<void> _setUserLoggedIn(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_logedInKey(), true);
    final storage = FlutterSecureStorage();
    await storage.write(key: _tokenKey(), value: token);
  }

  static Future<void> _setUserLoggedOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_logedInKey(), false);
    final storage = FlutterSecureStorage();
    storage.delete(key: _tokenKey());
  }

  static Future<bool> userLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool(_logedInKey()) ?? false;
    return loggedIn;
  }

  static Future<String> userToken() async {
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: _tokenKey());
    return token;
  }

//endregion
}
