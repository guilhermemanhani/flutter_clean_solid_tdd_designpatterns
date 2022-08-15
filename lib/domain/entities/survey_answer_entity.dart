class SurveyAnswerEntity {
  final String? image;
  final String answer;
  final bool isCurrentAnswer;
  final int percent;
  SurveyAnswerEntity({
    this.image,
    required this.answer,
    required this.isCurrentAnswer,
    required this.percent,
  });

  @override
  bool operator ==(covariant SurveyAnswerEntity other) {
    if (identical(this, other)) return true;

    return other.image == image &&
        other.answer == answer &&
        other.isCurrentAnswer == isCurrentAnswer &&
        other.percent == percent;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        answer.hashCode ^
        isCurrentAnswer.hashCode ^
        percent.hashCode;
  }
}
