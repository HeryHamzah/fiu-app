part of 'services.dart';

class TransactionServices {
  static CollectionReference _transactionCollection =
      FirebaseFirestore.instance.collection('transactions');

  static Future<void> saveTransaction(FiuTransaction transaction) async {
    await _transactionCollection.doc().set({
      'userID': transaction.userID,
      'title': transaction.title,
      'desc': transaction.desc,
      'amount': transaction.amount,
      'time': transaction.time.millisecondsSinceEpoch,
      'picturepath': transaction.picturePath,
    });
  }

  static Future<List<FiuTransaction>> getTransaction(String userID) async {
    QuerySnapshot snapshot = await _transactionCollection.get();

    var documents =
        snapshot.docs.where((document) => document.data()['userID'] == userID);

    return documents
        .map((e) => FiuTransaction(
            userID: userID,
            picturePath: e.data()['picturepath'],
            title: e.data()['title'],
            amount: e.data()['amount'],
            desc: e.data()['desc'],
            time: DateTime.fromMillisecondsSinceEpoch(e.data()['time'])))
        .toList();
  }
}
