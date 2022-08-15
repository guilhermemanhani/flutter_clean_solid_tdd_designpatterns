// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/domain/entities/entities.dart';

class SurveyResultEntity {
  final String surveyId;
  final String question;
  final List<SurveyAnswerEntity> answers;
  SurveyResultEntity({
    required this.surveyId,
    required this.question,
    required this.answers,
  });

  @override
  bool operator ==(covariant SurveyResultEntity other) {
    if (identical(this, other)) return true;

    return other.surveyId == surveyId &&
        other.question == question &&
        listEquals(other.answers, answers);
  }

  @override
  int get hashCode => surveyId.hashCode ^ question.hashCode ^ answers.hashCode;
}
