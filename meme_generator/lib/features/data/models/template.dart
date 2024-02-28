import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:meme_generator/features/domain/entities/template.dart';

import '../../domain/entities/text_data.dart';

@Entity(tableName: 'template')
class TemplateModel extends Template {
  @PrimaryKey(autoGenerate: true)
  @override
  int? id;

  TemplateModel(
      {this.id,
      Uint8List? imageBytes,
      String? uriToImage,
      required List<TextData> textList})
      : super(id: id, textList: textList, uriToImage: uriToImage, img: imageBytes);

  factory TemplateModel.fromEntity(Template template) => TemplateModel(
      id: template.id,
      imageBytes: template.img,
      uriToImage: template.uriToImage,
      textList: template.textList);
}
