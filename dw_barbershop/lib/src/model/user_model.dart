sealed class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });
}

class UserModelADM extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;
  UserModelADM({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours,
  });
}

class UserModelEmployee extends UserModel {
  final List<String> workDays;
  final List<int> workHours;
  UserModelEmployee({
    required super.id,
    required super.name,
    required super.email,
    required this.workDays,
    required this.workHours,
    super.avatar,
  });
}
