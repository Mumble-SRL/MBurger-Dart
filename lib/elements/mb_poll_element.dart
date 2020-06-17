import 'mb_general_element.dart';

class MBPollElement extends MBGeneralElement {
  List<MBPollAnswer> answers;

  bool answered;
  MBPollAnswer answer;
  DateTime expiration;

  MBPollElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    Map<String, dynamic> value = dictionary['value'];
    List<dynamic> answersFromApi = value['answers'];
    List<dynamic> resultsFromApi = value['results'];

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

    answered = value['answered'];
    int answerInt = value['answer'];
    if (answerInt != null && answers != null) {
      if (answerInt < answers.length) {
        answer = answers[answerInt];
      }
    }
  }
}

class MBPollAnswer {
  final String name;
  final int votes;

  MBPollAnswer(this.name, this.votes);
}

class MBPollVoteResponse {
  int myVoteIndex;
  List<int> votes;

  MBPollVoteResponse({Map<String, dynamic> dictionary}) {
    if (dictionary["mine"] is String) {
      myVoteIndex = int.tryParse(dictionary["mine"]) ?? 0;
    } else if (dictionary["mine"] is int) {
      myVoteIndex = dictionary["mine"];
    }
    if (dictionary["results"] != null) {
      List<dynamic> dynamicRes = dictionary["results"];
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
