import 'dart:io';

enum Fixture {
  user(folder: "auth/", fileName: 'user'),
  tokens(folder: "auth/", fileName: 'tokens'),
  tokensInvalid(folder: "auth/", fileName: 'tokens_invalid_');

  const Fixture({required this.folder, required this.fileName, this.fileExtension = ".json"});

  final String folder;
  final String fileName;
  final String fileExtension;

  String get filePath => folder + fileName + fileExtension;

  String filePathByVersion(int version) => folder + fileName + version.toString() + fileExtension;
}

String fixture(Fixture f, {int? version}) {
  try {
    return File('test/fixtures/${version != null ? f.filePathByVersion(version) : f.filePath}')
        .readAsStringSync();
  } catch (e) {
    print(version != null ? f.filePathByVersion(version) : f.filePath);
    print(e);
    return "{}";
  }
}
