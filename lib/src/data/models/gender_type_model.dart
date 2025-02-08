import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

enum GenderTypeModel {
  male('Male'),
  female('Female'),
  unknown('Unknown');

  const GenderTypeModel(this.name);

  final String name;

  static GenderTypeModel fromServer(String serverValue) {
    switch (serverValue.toLowerCase()) {
      case 'male':
      case 'Male':
        return GenderTypeModel.male;
      case 'female':
      case 'Female':
        return GenderTypeModel.female;
      default:
        return GenderTypeModel.unknown;
    }
  }

  GenderType toEntity() {
    switch (this) {
      case GenderTypeModel.male:
        return GenderType.male;
      case GenderTypeModel.female:
        return GenderType.female;
      case GenderTypeModel.unknown:
        return GenderType.unknown;
    }
  }
}
