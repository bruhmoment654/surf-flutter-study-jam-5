import 'package:floor/floor.dart';
import 'package:meme_generator/features/domain/entities/template.dart';

import '../../domain/entities/text_data.dart';

@Entity(tableName: 'template')
class TemplateModel extends Template {
  @PrimaryKey(autoGenerate: true)
  int? id;

  TemplateModel(this.id, {String? uriToImage, required List<TextData> textList})
      : super(textList: textList, uriToImage: uriToImage);

  factory TemplateModel.fromEntity(Template template) =>
      TemplateModel(
          null,
          uriToImage: template.uriToImage,
          textList: template.textList
      );
}
