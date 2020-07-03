import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'elements/mb_poll_element.dart';

import 'mb_auth/mb_auth.dart';
import 'mb_exception.dart';
import 'mb_section.dart';
import 'parameters/mb_parameter.dart';
import 'project/mb_project.dart';
import 'response/mb_paginated_response.dart';

/// The manager of the MBurger SDK, you will use this class to make requests to MBurger.
class MBManager {
  MBManager._privateConstructor();

  static final MBManager _shared = MBManager._privateConstructor();

  /// The singleton that manages all the data sent and received to/from MBurger.
  static MBManager get shared {
    return _shared;
  }

  /// The API token used to make all the requests to the apis.
  String apiToken;

  /// It's true if it's in development mode. Set this flag to use the MBurger development environment.
  bool development = false;

  /// The locale used to make the requests.
  String locale;

  /// The endpoint of MBurger, it uses the [development] flag to switch between dev and prod environments.
  String get endpoint {
    if (development) {
      return 'dev.mburger.cloud';
    } else {
      return 'mburger.cloud';
    }
  }

  /// The locale sent by the manger to the apis.
  String get localeForApi {
    if (locale != null) {
      locale.substring(0, 1);
    }
    return 'it';
  }

  /// Retrieve the block of the project with the specified id.
  /// - Parameters:
  ///   - [blockId]: The [blockId] of the block.
  ///   - [parameters]: An optional array of [MBParameter] used to sort, an empty array by default.
  ///   - [includeElements]: If [true] of the elements in the sections of the blocks are included in the response, `false` by default.
  /// - Returns a [Future] that completes with a paginated response of [MBSection]: the sections retrieved and information about pagination.
  Future<MBPaginatedResponse<MBSection>> getBlock({
    int blockId,
    List<MBParameter> parameters = const [],
    bool includeElements = false,
  }) async {
    if (blockId == null) {
      throw MBException('blockId must not be null');
    }

    Map<String, String> apiParameters = {};

    if (includeElements) {
      apiParameters['include'] = 'elements';
    }
    if (parameters != null) {
      parameters.forEach((parameter) {
        Map<String, String> representation = parameter.representation;
        if (representation != null) {
          apiParameters.addAll(representation);
        }
      });
    }

    String apiName = 'api/blocks/' + blockId.toString() + '/sections';

    apiParameters.addAll(await defaultParameters());

    var uri = Uri.https(endpoint, apiName, apiParameters);
    var response = await http.get(uri, headers: await headers());
    Map<String, dynamic> body = MBManager.checkResponse(response.body);
    Map<String, dynamic> meta = body['meta'] as Map<String, dynamic>;
    List<Map<String, dynamic>> items =
        List<Map<String, dynamic>>.from(body['items'] as List);
    return MBPaginatedResponse<MBSection>(
      from: meta['from'] as int,
      to: meta['to'] as int,
      total: meta['total'] as int,
      items: items.map((item) => MBSection.fromDictionary(item)).toList(),
    );
  }

  /// Retrieve the sections of the block with the specified id.
  /// - Parameters:
  ///   - [blockId]: The [blockId] of the block.
  ///   - [parameters]: An optional array of [MBParameter] used to sort, an empty array by default.
  ///   - [includeElements]: If [true] of the elements in the sections of the blocks are included in the response, `false` by default.
  /// - Returns a [Future] that completes with a paginated response of [MBSection]: the sections retrieved and information about pagination.
  Future<MBPaginatedResponse<MBSection>> getSections({
    int blockId,
    List<MBParameter> parameters = const [],
    bool includeElements = false,
  }) async {
    if (blockId == null) {
      throw MBException('blockId must not be null');
    }

    Map<String, String> apiParameters = {};

    if (includeElements) {
      apiParameters['include'] = 'elements';
    }
    if (parameters != null) {
      parameters.forEach((parameter) {
        Map<String, String> representation = parameter.representation;
        if (representation != null) {
          apiParameters.addAll(representation);
        }
      });
    }

    String apiName = 'api/blocks/' + blockId.toString() + '/sections';

    apiParameters.addAll(await defaultParameters());

    var uri = Uri.https(endpoint, apiName, apiParameters);
    var response = await http.get(uri, headers: await headers());
    Map<String, dynamic> body = MBManager.checkResponse(response.body);
    Map<String, dynamic> meta = body['meta'] as Map<String, dynamic>;
    List<Map<String, dynamic>> items =
        List<Map<String, dynamic>>.from(body['items'] as List);
    return MBPaginatedResponse<MBSection>(
      from: meta['from'] as int,
      to: meta['to'] as int,
      total: meta['total'] as int,
      items: items.map((item) => MBSection.fromDictionary(item)).toList(),
    );
  }

  /// Retrieve the sections with the specified id.
  /// - Parameters:
  ///   - [sectionId]: The [sectionId] of the section.
  ///   - [includeElements]: If [true] of the elements in the sections of the blocks are included in the response, `false` by default.
  /// - Returns a [Future] that completes with the [MBSection] retrieved.
  Future<MBSection> getSection({
    int sectionId,
    bool includeElements = false,
  }) async {
    if (sectionId == null) {
      throw MBException('sectionId must not be null');
    }

    Map<String, String> apiParameters = {};

    if (includeElements) {
      apiParameters['include'] = 'elements';
    }

    String apiName = 'api/sections/' + sectionId.toString();

    apiParameters.addAll(await defaultParameters());

    var uri = Uri.https(endpoint, apiName, apiParameters);
    var response = await http.get(uri, headers: await headers());
    Map<String, dynamic> body = MBManager.checkResponse(response.body);

    return MBSection.fromDictionary(body);
  }

  /// Retrieve the MBurger project.
  /// - Parameters:
  ///   - [includeContracts]: if this is [true] the contracts are included in the project object.
  /// - Returns a [Future] that completes with the [MBProject] retrieved.
  Future<MBProject> getProject({bool includeContracts = false}) async {
    Map<String, String> apiParameters = {};

    if (includeContracts) {
      apiParameters['include'] = 'contracts';
    }

    String apiName = 'api/project';

    apiParameters.addAll(await defaultParameters());

    var uri = Uri.https(endpoint, apiName, apiParameters);
    var response = await http.get(uri, headers: await headers());
    Map<String, dynamic> body = MBManager.checkResponse(response.body);
    return MBProject.fromDictionary(body);
  }

  /// Votes for a poll.
  /// - Parameters:
  ///   - [pollId]: the id of the poll element.
  ///   - [answerIndex]: this index of the answer voted for.
  /// - Returns a [Future] that completes with the [MBPollVoteResponse] posted to MBurger.
  Future<MBPollVoteResponse> votePoll(int pollId, int answerIndex) async {
    Map<String, dynamic> apiParameters = {};

    apiParameters['element_id'] = pollId.toString();
    apiParameters['vote'] = answerIndex.toString();

    apiParameters.addAll(await MBManager.shared.defaultParameters());

    String apiName = 'api/vote-poll';

    var requestBody = json.encode(apiParameters);

    Map<String, String> headers =
        await MBManager.shared.headers(contentTypeJson: true);

    var uri = Uri.https(MBManager.shared.endpoint, apiName);

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: requestBody,
    );

    Map<String, dynamic> body = MBManager.checkResponse(response.body);
    return MBPollVoteResponse(dictionary: body);
  }

  /// Checks the response of the api call and returns the body, it throws a [MBException] if it encounters an error.
  /// - Parameters:
  ///   - [response]: The [response] string that needs to be checked.
  ///   - [checkBody]: If [true] this function checks if in the response there's a "body" value, otherwise it skips this check, `true` by default.
  /// - Returns a Map<String, dynamic> object which is the body of the response.
  static Map<String, dynamic> checkResponse(
    String response, {
    bool checkBody = true,
  }) {
    final responseJson = json.decode(response);
    Map<String, dynamic> responseDecoded = responseJson as Map<String, dynamic>;
    int statusCode = responseDecoded["status_code"] as int ?? -1;
    if (statusCode == 0) {
      if (checkBody) {
        Map<String, dynamic> responseBody =
            responseDecoded["body"] as Map<String, dynamic>;
        if (responseBody != null) {
          return responseBody;
        } else {
          throw MBException(
            "Can't find response body",
            statusCode: statusCode,
          );
        }
      } else {
        return null;
      }
    } else {
      String errorString = _errorString(responseDecoded);
      throw MBException(
        errorString ?? "There was an error, retry later",
        statusCode: statusCode,
      );
    }
  }

  static String _errorString(Map<String, dynamic> responseDecoded) {
    String message = responseDecoded["message"] as String;
    if (responseDecoded["errors"] != null) {
      String errorsString = '';
      Map<String, dynamic> errors =
          responseDecoded["errors"] as Map<String, dynamic>;
      for (String key in errors.keys) {
        dynamic value = errors[key];
        if (value is String) {
          errorsString += errorsString == '' ? value : '\n$value';
        } else if (value is List) {
          for (var v in value) {
            if (v is String) {
              errorsString += errorsString == '' ? v : '\n$v';
            }
          }
        }
      }
      if (errorsString != '') {
        return errorsString;
      }
    }
    return message;
  }

  /// Default headers sent to MBurger.
  /// - Parameters:
  ///   - [contentTypeJson]: if [true] it adds this header [Content-Type: application/json].
  /// - Returns a Future that completes with the map of default headers.
  Future<Map<String, String>> headers({bool contentTypeJson = false}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'X-MBurger-Token': apiToken,
      'X-MBurger-Version': '3',
    };
    if (await MBAuth.userLoggedIn() != null) {
      String token = await MBAuth.userToken();
      headers['Authorization'] = 'Bearer $token';
    }

    if (contentTypeJson) {
      headers['Content-Type'] = 'application/json';
    }
    return headers;
  }

  /// Default parameters sent to MBurger.
  /// - Returns a Future that completes with the map of default parameters.
  Future<Map<String, String>> defaultParameters() async {
    Map<String, String> defaultParameters = {
      'os': Platform.isIOS ? 'ios' : 'android',
      'locale': localeForApi,
    };
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      defaultParameters['device_id'] = androidInfo.androidId;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      defaultParameters['device_id'] = iosInfo.identifierForVendor;
    }
    return defaultParameters;
  }
}
