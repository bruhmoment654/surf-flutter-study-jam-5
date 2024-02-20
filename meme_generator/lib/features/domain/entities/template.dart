import 'package:floor/floor.dart';
import 'package:meme_generator/features/domain/entities/text_data.dart';

import '../../data/data_sources/local/type_converter.dart';

class Template {
  final String? uriToImage;

  @TypeConverters([StringListConverter])
  final List<TextData> textList;

  const Template({this.uriToImage = 'https://sun9-52.userapi.com/impg/hDDskwX-sDS77Pce0EjkSdeU_QTx-AKXJX2yvw/uFuangQK-nA.jpg?size=400x400&quality=95&sign=b73e67503346c80d5f0b493434157b0e&type=album', required this.textList});
}
