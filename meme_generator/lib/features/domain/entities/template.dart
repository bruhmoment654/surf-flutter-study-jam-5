import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:meme_generator/features/domain/entities/text_data.dart';

import '../../data/data_sources/local/type_converter.dart';

class Template {
  Uint8List? img;
  final String? uriToImage;

  @TypeConverters([StringListConverter])
  final List<TextData> textList;

  Template({this.img, this.uriToImage, required this.textList});

  @override
  String toString() {
    return 'Template{img: $img, uriToImage: $uriToImage, textList: $textList}';
  }
}
