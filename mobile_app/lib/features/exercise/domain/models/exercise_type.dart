enum ExerciseType {
  multipleChoice,
  fillInBlank,
  matching,
  trueFalse;

  String toJson() {
    switch (this) {
      case ExerciseType.multipleChoice:
        return 'MULTIPLE_CHOICE';
      case ExerciseType.fillInBlank:
        return 'FILL_IN_BLANK';
      case ExerciseType.matching:
        return 'MATCHING';
      case ExerciseType.trueFalse:
        return 'TRUE_FALSE';
    }
  }

  static ExerciseType fromJson(String json) {
    switch (json) {
      case 'MULTIPLE_CHOICE':
        return ExerciseType.multipleChoice;
      case 'FILL_IN_BLANK':
        return ExerciseType.fillInBlank;
      case 'MATCHING':
        return ExerciseType.matching;
      case 'TRUE_FALSE':
        return ExerciseType.trueFalse;
      default:
        return ExerciseType.multipleChoice;
    }
  }
}
