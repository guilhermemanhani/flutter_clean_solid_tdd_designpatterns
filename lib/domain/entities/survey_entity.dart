class SurveyEntity {
  final String id;
  final String question;
  final DateTime dateTime;
  final bool didAnswer;

  SurveyEntity({
    required this.id,
    required this.question,
    required this.dateTime,
    required this.didAnswer,
  });

  @override
  bool operator ==(covariant SurveyEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.question == question &&
        other.dateTime == dateTime &&
        other.didAnswer == didAnswer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question.hashCode ^
        dateTime.hashCode ^
        didAnswer.hashCode;
  }
}
