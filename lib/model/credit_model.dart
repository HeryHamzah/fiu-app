part of 'models.dart';

class Credits extends Equatable {
  final String name;
  final String profilePath;
  final String character;

  Credits({this.name, this.profilePath, this.character});

  @override
  List<Object> get props => [name, profilePath, character];
}
