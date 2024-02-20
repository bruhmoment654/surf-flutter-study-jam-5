import 'package:floor/floor.dart';
import 'package:meme_generator/features/domain/entities/text_data.dart';

class StringListConverter extends TypeConverter<List<TextData>, String> {
  @override
  List<TextData> decode(String databaseValue) {
    var  a = databaseValue.split(',').map((e) {
      List temp = e.split(':');
      return TextData(text: temp[0], position: double.parse(temp[1]));
    }).toList();
    return a;
  }

  @override
  String encode(List<TextData> value) {
    return value.map((e) => '${e.text}:${e.position}').join(',');
  }
}
