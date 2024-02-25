import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:meme_generator/features/domain/entities/template.dart';

import '../../domain/entities/text_data.dart';

@Entity(tableName: 'template')
class TemplateModel extends Template {
  @PrimaryKey(autoGenerate: true)
  int? id;

  TemplateModel(
      {this.id,
      Uint8List? imageBytes,
      String? uriToImage,
      required List<TextData> textList})
      : super(textList: textList, uriToImage: uriToImage, img: imageBytes);

  factory TemplateModel.fromEntity(Template template) => TemplateModel(
      id: null,
      imageBytes: template.img,
      uriToImage: template.uriToImage,
      textList: template.textList);
}
