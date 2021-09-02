part of 'models.dart';

class FiuTransaction extends Equatable {
  final String userID;
  final String picturePath;
  final String title;
  final int amount;
  final String desc;
  final DateTime time;

  FiuTransaction(
      {this.userID,
      this.picturePath,
      this.title,
      this.amount,
      this.desc,
      this.time});
  @override
  List<Object> get props => [userID, picturePath, title, amount, desc, time];
}
