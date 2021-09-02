part of 'shared.dart';

void showSnackBar(BuildContext context, String message) {
  showTopSnackBar(
    context,
    CustomSnackBar.info(
      backgroundColor: mainColor,
      message: message,
      textStyle: TextStyle(fontSize: 14, color: Colors.white),
    ),
  );
}

Future<String> uploadImageToFirebaseStorage(File imageFile) async {
  String fileName = basename(imageFile.path);

  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask task = ref.putFile(imageFile);
  StorageTaskSnapshot snapshot = await task.onComplete;

  return await snapshot.ref.getDownloadURL();
}

Future<File> getImage() async {
  final imageFile = await ImagePicker()
      .getImage(source: ImageSource.gallery, imageQuality: 50);

  if (imageFile == null) {
    return null;
  }

  final image = File(imageFile.path);

  return image;
}
