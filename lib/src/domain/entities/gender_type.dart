enum GenderType {
  male,
  female,
  unknown,
  none;

  bool get isMale => this == male;
  bool get isFemale => this == female;
  bool get isUnknown => this == unknown;
  bool get isNone => this == none;

  static List<GenderType> get valuesList =>
      GenderType.values.where((gender) => gender != GenderType.none).toList();
}
