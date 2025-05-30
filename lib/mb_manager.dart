import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:mburger/elements/mb_media_element.dart';
import 'package:mburger/mb_block.dart';
import 'package:mburger/mb_plugin/mb_plugin.dart';
import 'elements/mb_poll_element.dart';

import 'mb_auth/mb_auth.dart';
import 'mb_exception.dart';
import 'mb_section.dart';
import 'parameters/mb_parameter.dart';
import 'project/mb_project.dart';
import 'response/mb_paginated_response.dart';

/// The channel of MBurger that will be queried
enum MBurgerChannel {
  /// The stable channel of MBurger
  stable,

  /// The develop channel of MBurger
  develop,

  /// The master channel of MBurger, with the lastest changes
  master,
}

/// The manager of the MBurger SDK, you will use this class to make requests to MBurger.
class MBManager {
  /// Internal initializer, used when initializing the singleton
  MBManager._privateConstructor({required this.channel});

  /// Initializes a [MBManager] with an [apiToken].
  /// - Parameters:
  ///   - [locale]: An optional locale used to call the make the requests.
  ///   - [channel]: The MBurger channel to connect to, defaults to `stable`.
  MBManager({
    required this.apiToken,
    this.locale,
    this.channel = MBurgerChannel.stable,
  });

  static final MBManager _shared = MBManager._privateConstructor(
    channel: MBurgerChannel.stable,
  );

  /// The singleton that manages all the data sent and received to/from MBurger.
  static MBManager get shared {
    return _shared;
  }

  /// The API token used to make all the requests to the apis.
  String? apiToken;

  /// The MBurger channel that will be queried (stable/develop/master).
  MBurgerChannel channel;

  /// The locale used to make the requests.
  String? locale;

  /// The endpoint of MBurger, it uses the [development] flag to switch between dev and prod environments.
  String get endpoint {
    switch (channel) {
      case MBurgerChannel.stable:
        return 'mburger.cloud';
      case MBurgerChannel.develop:
        return 'dev.mburger.cloud';
      case MBurgerChannel.master:
        return 'staging.mburger.cloud';
      // ignore: unreachable_switch_default
      default:
        return 'mburger.cloud';
    }
  }

  /// The locale sent by the manger to the apis.
  String get localeForApi {
    if (locale != null) {
      if (locale!.length >= 2) {
        return locale!.substring(0, 2);
      }
    }
    return 'it';
  }

  /// Additional plugins for MBurger
  List<MBPlugin> _plugins = [];

  /// Additional plugins for MBurger
  set plugins(List<MBPlugin> plugins) {
    plugins.sort((p1, p2) => p1.startupOrder.compareTo(p2.startupOrder));
    _plugins = plugins;
    for (MBPlugin plugin in plugins) {
      plugin.startupBlock();
    }
  }

  /// Additional plugins for MBurger
  List<MBPlugin> get plugins => _plugins;

  /// Returns the plugin of the specified type in the array of plugins
  T? pluginOf<T>() {
    MBPlugin? plugin = _plugins.firstWhereOrNull(
      (plugin) => plugin is T,
    );
    if (plugin != null) {
      return plugin as T;
    }
    return null;
  }

  /// Retrieve the blocks of the project.
  /// - Parameters:
  ///   - [parameters]: An optional array of [MBParameter] used to sort, an empty array by default.
  ///   - [includeSections]: If [true] the sections of the block are included in the response, `false` by default.
  ///   - [includeElements]: If [true] the elements in the sections of the blocks are included in the response, `false` by default.
  /// - Returns a [Future] that completes with a paginated response of [MBBlock]: the blocks retrieved and information about pagination.
  Future<MBPaginatedResponse<MBBlock>> getBlocks({
    List<MBParameter> parameters = const [],
    bool includeSections = false,
    bool includeElements = false,
  }) async {
    Map<String, String> apiParameters = {};

    if (includeSections) {
      apiParameters['include'] =
          includeElements ? 'sections.elements' : 'sections';
    }

    for (MBParameter parameter in parameters) {
      Map<String, String> representation = parameter.representation;
      if (representation.isNotEmpty) {
        apiParameters.addAll(representation);
      }
    }

    String apiName = 'api/blocks/';

    apiParameters.addAll(await defaultParameters());

    var uri = Uri.https(endpoint, apiName, apiParameters);
    var response = await http.get(uri, headers: await headers());
    Map<String, dynamic> body = MBManager.checkResponse(response.body);
    Map<String, dynamic> meta = body['meta'] as Map<String, dynamic>;
    List<Map<String, dynamic>> items =
        List<Map<String, dynamic>>.from(body['items'] as List);
    return MBPaginatedResponse<MBBlock>(
      from: meta['from'] as int,
      to: meta['to'] as int,
      total: meta['total'] as int,
      items: items.map((item) => MBBlock.fromDictionary(item)).toList(),
    );
  }

  /// Retrieve the block of the project with the specified id.
  /// - Parameters:
  ///   - [blockId]: The [blockId] of the block.
  ///   - [parameters]: An optional array of [MBParameter] used to sort, an empty array by default.
  ///   - [includeSections]: If [true] the sections of the block are included in the response, `false` by default.
  ///   - [includeElements]: If [true] the elements in the sections of the blocks are included in the response, `false` by default.
  /// - Returns a [Future] that completes with a MBBlock which is the block retrieved.
  Future<MBBlock> getBlock({
    required int blockId,
    List<MBParameter> parameters = const [],
    bool includeSections = false,
    bool includeElements = false,
  }) async {
    Map<String, String> apiParameters = {};

    if (includeSections) {
      apiParameters['include'] =
          includeElements ? 'sections.elements' : 'sections';
    }

    for (MBParameter parameter in parameters) {
      Map<String, String> representation = parameter.representation;
      if (representation.isNotEmpty) {
        apiParameters.addAll(representation);
      }
    }

    String apiName = 'api/blocks/$blockId';

    apiParameters.addAll(await defaultParameters());

    var uri = Uri.https(endpoint, apiName, apiParameters);
    var response = await http.get(uri, headers: await headers());
    Map<String, dynamic> body = MBManager.checkResponse(response.body);
    MBBlock block = MBBlock.fromDictionary(body);

    return block;
  }

  /// Retrieve the sections of the block with the specified id.
  /// - Parameters:
  ///   - [blockId]: The [blockId] of the block.
  ///   - [parameters]: An optional array of [MBParameter] used to sort, an empty array by default.
  ///   - [includeElements]: If [true] of the elements in the sections of the blocks are included in the response, `false` by default.
  /// - Returns a [Future] that completes with a paginated response of [MBSection]: the sections retrieved and information about pagination.
  Future<MBPaginatedResponse<MBSection>> getSections({
    required int blockId,
    List<MBParameter> parameters = const [],
    bool includeElements = false,
  }) async {
    Map<String, String> apiParameters = {};

    if (includeElements) {
      apiParameters['include'] = 'elements';
    }

    for (MBParameter parameter in parameters) {
      Map<String, String> representation = parameter.representation;
      if (representation.isNotEmpty) {
        apiParameters.addAll(representation);
      }
    }

    String apiName = 'api/blocks/$blockId/sections';

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
  ///   - [parameters]: An optional array of [MBParameter], an empty array by default.
  ///   - [includeElements]: If [true] of the elements in the sections of the blocks are included in the response, `false` by default.
  /// - Returns a [Future] that completes with the [MBSection] retrieved.
  Future<MBSection> getSection({
    required int sectionId,
    List<MBParameter> parameters = const [],
    bool includeElements = false,
  }) async {
    Map<String, String> apiParameters = {};

    if (includeElements) {
      apiParameters['include'] = 'elements';
    }

    for (MBParameter parameter in parameters) {
      Map<String, String> representation = parameter.representation;
      if (representation.isNotEmpty) {
        apiParameters.addAll(representation);
      }
    }

    String apiName = 'api/sections/$sectionId';

    apiParameters.addAll(await defaultParameters());

    var uri = Uri.https(endpoint, apiName, apiParameters);
    var response = await http.get(uri, headers: await headers());
    Map<String, dynamic> body = MBManager.checkResponse(response.body);

    return MBSection.fromDictionary(body);
  }

  /// Retrieve the sections with the specified slug.
  /// - Parameters:
  ///   - [slug]: The [slug] of the section.
  ///   - [parameters]: An optional array of [MBParameter], an empty array by default.
  ///   - [includeElements]: If [true] of the elements in the sections of the blocks are included in the response, `false` by default.
  /// - Returns a [Future] that completes with the [MBSection] retrieved.
  Future<MBSection> getSectionWithSlug({
    required String slug,
    List<MBParameter> parameters = const [],
    bool includeElements = false,
  }) async {
    Map<String, String> apiParameters = {};

    apiParameters['use_slug'] = 'true';
    if (includeElements) {
      apiParameters['include'] = 'elements';
    }

    for (MBParameter parameter in parameters) {
      Map<String, String> representation = parameter.representation;
      apiParameters.addAll(representation);
    }

    String apiName = 'api/sections/$slug';

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

    apiParameters.addAll(await defaultParameters());

    String apiName = 'api/vote-poll';

    var requestBody = json.encode(apiParameters);

    var uri = Uri.https(endpoint, apiName);

    http.Response response = await http.post(
      uri,
      headers: await headers(contentTypeJson: true),
      body: requestBody,
    );

    Map<String, dynamic> body = MBManager.checkResponse(response.body);
    return MBPollVoteResponse(dictionary: body);
  }

  /// Retrieve the media of the project with the specified id.
  /// - Parameters:
  ///   - [mediaId]: The id of the media to retrieve.
  /// - Returns a [Future] that completes with the [MBMedia] retrieved.
  Future<MBMedia> getMedia(int mediaId) async {
    Map<String, String> apiParameters = {};
    String apiName = 'api/media/$mediaId';

    apiParameters.addAll(await defaultParameters());

    var uri = Uri.https(endpoint, apiName, apiParameters);
    var response = await http.get(uri, headers: await headers());
    Map<String, dynamic> body = MBManager.checkResponse(response.body);
    return MBMedia(dictionary: body);
  }

  /// Retrieve all the media of the project.
  /// - Returns a [Future] that completes with the all the [MBMedia] saved in the media center of the project.
  Future<List<MBMedia>> getAllMedia() async {
    Map<String, String> apiParameters = {};
    String apiName = 'api/media';

    apiParameters.addAll(await defaultParameters());

    var uri = Uri.https(endpoint, apiName, apiParameters);
    var response = await http.get(uri, headers: await headers());
    List<dynamic>? body =
        MBManager.checkResponseForType<List<dynamic>>(response.body);
    List<Map<String, dynamic>> bodyArray =
        List.castFrom<dynamic, Map<String, dynamic>>(body);
    return bodyArray.map((d) => MBMedia(dictionary: d)).toList();
  }

  /// Checks the response of the api call and returns the body, it throws a [MBException] if it encounters an error.
  /// - Parameters:
  ///   - [response]: The [response] string that needs to be checked.
  ///   - [checkBody]: If [true] this function checks if in the response there's a "body" value, otherwise it skips this check, `true` by default.
  /// - Returns a Map<String, dynamic> object which is the body of the response.
  static Map<String, dynamic> checkResponse(
    String response, {
    bool checkBody = true,
  }) =>
      checkResponseForType<Map<String, dynamic>>(
        response,
        checkBody: checkBody,
      );

  /// Function to check the response of the api and parse the response as the type passed
  /// - Parameters:
  ///   - [T]: The class of the object in which the body will be casted.
  ///   - [response]: The [response] string that needs to be checked.
  ///   - [checkBody]: If [true] this function checks if in the response there's a "body" value, otherwise it skips this check, `true` by default.
  /// - Returns an object of typ `T` which is the body of the response.
  static T checkResponseForType<T>(
    String response, {
    bool checkBody = true,
  }) {
    final responseJson = json.decode(response);
    Map<String, dynamic> responseDecoded = responseJson as Map<String, dynamic>;
    int statusCode = -1;
    if (responseDecoded["status_code"] is int) {
      statusCode = responseDecoded["status_code"] as int;
    }
    if (statusCode == 0) {
      if (checkBody) {
        T responseBody = responseDecoded["body"] as T;
        if (responseBody != null) {
          return responseBody;
        } else {
          throw MBException(
            statusCode: statusCode,
            message: "Can't find response body",
          );
        }
      } else {
        if (responseDecoded is T) {
          return responseDecoded as T;
        } else {
          throw MBException(
            statusCode: 450,
            message: "Wrong response type",
          );
        }
      }
    } else {
      MBException exception = _exceptionFromResponse(responseDecoded);
      throw exception;
    }
  }

  static MBException _exceptionFromResponse(
    Map<String, dynamic> responseDecoded,
  ) {
    int statusCode = -1;
    if (responseDecoded["status_code"] is int) {
      statusCode = responseDecoded["status_code"] as int;
    }
    String message = responseDecoded["message"] as String;
    List<String>? errors;
    if (responseDecoded["errors"] != null) {
      errors = [];
      Map<String, dynamic> errorsDictionary =
          responseDecoded["errors"] as Map<String, dynamic>;
      for (String key in errorsDictionary.keys) {
        dynamic value = errorsDictionary[key];
        if (value is String) {
          errors.add(value);
        } else if (value is List) {
          List<String> valueAsStrings = List.castFrom<dynamic, String>(value);
          errors.add(valueAsStrings.join(', '));
        }
      }
    }
    return MBException(
      statusCode: statusCode,
      message: message,
      errors: errors,
    );
  }

  /// Default headers sent to MBurger.
  /// - Parameters:
  ///   - [contentTypeJson]: if [true] it adds this header [Content-Type: application/json].
  /// - Returns a Future that completes with the map of default headers.
  Future<Map<String, String>> headers({bool contentTypeJson = false}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'X-MBurger-Version': '3',
    };

    if (apiToken != null) {
      headers['X-MBurger-Token'] = apiToken!;
    }

    bool userLoggedIn = await MBAuth.userLoggedIn();
    if (userLoggedIn == true) {
      String? token = await MBAuth.userToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
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
      'locale': localeForApi,
    };
    if (!kIsWeb) {
      defaultParameters['os'] = Platform.isIOS ? 'ios' : 'android';
    }
    String? deviceId = await _deviceId();
    if (deviceId != null) {
      defaultParameters['device_id'] = deviceId;
    }
    return defaultParameters;
  }

  Future<String?> _deviceId() async {
    if (!kIsWeb) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        const androidIdPlugin = AndroidId();
        String? androidId = await androidIdPlugin.getId();
        return androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor;
      }
    }
    return null;
  }
}
