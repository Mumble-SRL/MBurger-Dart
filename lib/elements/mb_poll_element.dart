import 'package:mburger/elements/mb_element.dart';

/// This class represents a MBurger poll element, the property answers contains the answers the user can give to a the poll.
class MBPollElement extends MBElement {
  /// The possible answers for the poll.
  final List<MBPollAnswer> answers;

  /// If the current user/device has answered.
  final bool answered;

  /// The answer.
  final MBPollAnswer? answer;

  /// The expiration date of the poll.
  final DateTime? expiration;

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [answers]: The possible answers for the poll
  ///   - [answered]: If the current user/device has answered
  ///   - [answer]: The answer
  ///   - [expiration]: The expiration date of the poll
  MBPollElement._({
    required super.dictionary,
    required this.answers,
    required this.answered,
    required this.answer,
    required this.expiration,
  });

  /// Initializes a poll element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBPollElement({required Map<String, dynamic> dictionary}) {
    List<MBPollAnswer> answers = [];
    bool answered = false;
    MBPollAnswer? answer;
    DateTime? expiration;

    if (dictionary['value'] is Map<String, dynamic>) {
      Map<String, dynamic> value = dictionary['value'] as Map<String, dynamic>;
      List<dynamic> answersFromApi = value['answers'] as List;
      List<dynamic> resultsFromApi = value['results'] as List;

      int index = 0;
      for (var answer in answersFromApi) {
        if (answer != null &&
            answer is String &&
            index < resultsFromApi.length) {
          dynamic votesFromDict = resultsFromApi[index];
          int votes = 0;
          if (votesFromDict is int) {
            votes = votesFromDict;
          } else if (votesFromDict is double) {
            votes = votesFromDict.toInt();
          }
          answers.add(MBPollAnswer(answer, votes));
        }
        index++;
      }

      if (value['answered'] is bool) {
        answered = value['answered'] as bool;
      }
      if (value['answer'] is int) {
        int answerInt = value['answer'] as int;
        if (answerInt < answers.length) {
          answer = answers[answerInt];
        }
      }

      if (value['ends_at'] is int) {
        int endsAtTimestamp = value['ends_at'] as int;
        expiration =
            DateTime.fromMillisecondsSinceEpoch(endsAtTimestamp * 1000);
      }
    }

    return MBPollElement._(
      dictionary: dictionary,
      answers: answers,
      answered: answered,
      answer: answer,
      expiration: expiration,
    );
  }
}

/// An answer for an MBurger poll.
class MBPollAnswer {
  /// The answer name.
  final String name;

  /// The number of votes for this answer.
  final int votes;

  MBPollAnswer(this.name, this.votes);
}

/// The response returned by a vote poll from [MBManager.votePoll].
class MBPollVoteResponse {
  /// The index of my vote.
  int myVoteIndex;

  /// The total list of votes.
  List<int> votes;

  /// Private initializer to initialize all variables using the factory initializer
  MBPollVoteResponse._({
    required this.myVoteIndex,
    required this.votes,
  });

  /// Initializes a vote poll response with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBPollVoteResponse({required Map<String, dynamic> dictionary}) {
    int myVoteIndex = 0;
    List<int> votes = [];
    if (dictionary["mine"] is String) {
      myVoteIndex = int.tryParse(dictionary["mine"] as String) ?? 0;
    } else if (dictionary["mine"] is int) {
      myVoteIndex = dictionary["mine"] as int;
    }
    if (dictionary["results"] != null) {
      List<dynamic> dynamicRes = dictionary["results"] as List;
      for (dynamic res in dynamicRes) {
        if (res is int) {
          votes.add(res);
        } else {
          votes.add(0);
        }
      }
    }
    return MBPollVoteResponse._(
      myVoteIndex: myVoteIndex,
      votes: votes,
    );
  }
}
