import 'mb_general_element.dart';

/// This class represents a MBurger poll element, the property answers contains the answers the user can give to a the poll.
class MBPollElement extends MBGeneralElement {
  /// The possible answers for the poll.
  List<MBPollAnswer> answers;

  /// If the current user/device has answered.
  bool answered;

  /// The answer.
  MBPollAnswer answer;

  /// The expiration date of the poll.
  DateTime expiration;

  /// Initializes a poll element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBPollElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    Map<String, dynamic> value = dictionary['value'] as Map<String, dynamic>;
    List<dynamic> answersFromApi = value['answers'] as List;
    List<dynamic> resultsFromApi = value['results'] as List;

    answers = [];

    int index = 0;
    for (var answer in answersFromApi) {
      if (answer != null && answer is String && index < resultsFromApi.length) {
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

    answered = value['answered'] as bool;
    int answerInt = value['answer'] as int;
    if (answerInt != null && answers != null) {
      if (answerInt < answers.length) {
        answer = answers[answerInt];
      }
    }
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

/// The response returned by a vote poll from [MBManager.shared.votePoll].
class MBPollVoteResponse {
  /// The index of my vote.
  int myVoteIndex;

  /// The total list of votes.
  List<int> votes;

  /// Initializes a vote poll response with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBPollVoteResponse({Map<String, dynamic> dictionary}) {
    if (dictionary["mine"] is String) {
      myVoteIndex = int.tryParse(dictionary["mine"] as String) ?? 0;
    } else if (dictionary["mine"] is int) {
      myVoteIndex = dictionary["mine"] as int;
    }
    if (dictionary["results"] != null) {
      List<dynamic> dynamicRes = dictionary["results"] as List;
      votes = List<int>();
      for (dynamic res in dynamicRes) {
        if (res is int) {
          votes.add(res);
        } else {
          votes.add(0);
        }
      }
    }
  }
}
