import 'dart:io';

enum Fixture {
  user(fileName: 'user.json');

  const Fixture({required this.fileName});

  final String fileName;
}

String fixture(Fixture f) => File('test/fixtures/${f.fileName}').readAsStringSync();
