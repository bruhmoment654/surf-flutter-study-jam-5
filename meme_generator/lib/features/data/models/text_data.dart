import 'package:floor/floor.dart';
import 'package:meme_generator/features/domain/entities/text_data.dart';

@Entity(tableName: 'textdata', primaryKeys: ['id'])
class TextDataModel extends TextData {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  TextDataModel(this.id, {required String text, required double position})
      : super(text: text, position: position);


  factory TextDataModel.fromEntity(TextData textData) =>
      TextDataModel(null, text: textData.text, position: textData.position);
}
