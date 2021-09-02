part of 'models.dart';

class RegistrationData {
  String email;
  String name;
  String password;
  File profilePicture;
  List<String> selectedGenres;
  String selectedYear;

  RegistrationData(
      {this.email = "",
      this.name = "",
      this.password = "",
      this.selectedGenres = const [],
      this.selectedYear = "",
      this.profilePicture});
}
