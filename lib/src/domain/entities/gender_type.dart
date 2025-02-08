enum GenderType {
  male,
  female,
  unknown;

  bool get isMale => this == male;
  bool get isFemale => this == female;
  bool get isUnknown => this == unknown;
}
