import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/core/constants/constants.dart';
import 'package:meme_generator/features/domain/entities/template.dart';
import 'package:meme_generator/features/domain/entities/text_data.dart';
import 'package:meme_generator/features/domain/usecases/save_template.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_bloc.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_event.dart';
import 'package:meme_generator/features/presentation/widgets/custom_text_field.dart';
import 'package:meme_generator/features/presentation/widgets/demotivator.dart';
import 'package:meme_generator/features/presentation/widgets/drawer.dart';

import '../../../injection_container.dart';

class CreateTemplatePage extends StatefulWidget {
  const CreateTemplatePage({super.key});

  @override
  State<CreateTemplatePage> createState() => _CreateTemplatePageState();
}

class _CreateTemplatePageState extends State<CreateTemplatePage> {
  final Template _template = defaultTemplate;

  Image? _image;

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _textInputs = [];

  @override
  Widget build(BuildContext context) {
    _textInputs.clear();
    _template.textList.forEachIndexed((index, textDataItem) {
      _textInputs.add(_textInputColumn(index));
    });

    return BlocProvider(
      create: (_) => sl<LocalTemplateBloc>(),
      child: Scaffold(
        drawer: const MyDrawer(),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () => _onFloatingActionButtonPressed(context),
            child: const Icon(Icons.save),
          );
        }),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ListView(
              children: [
                ...[
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: Demotivator(
                        onTap: _setGalleryImage,
                        template: _template,
                        child: _image ?? const Column()),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
                ..._textInputs,
                ...[
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.greenAccent),
                        onPressed: _addTemplate,
                        icon: const Icon(Icons.add)),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addTemplate() {
    setState(() {
      _template.textList.add(TextData(text: 'PLACEHOLDER', position: 0));
    });
  }

  _textInputColumn(int index) {
    return Column(
      children: [
        OutlinedTextFormField(
          style: const TextStyle(color: Colors.white),
          hintText: 'Enter demotivator text',
          onDataChanged: (data) {
            setState(() {
              _template.textList[index].text = data;
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Slider(
            min: 0,
            max: 100,
            value: _template.textList[index].position,
            onChanged: (value) => setState(() {
                  _template.textList[index].position = value;
                }))
      ],
    );
  }

  _setGalleryImage() async {
    final image = await _getFromGallery();
    setState(() {
      _image = Image.file(
        File(image!.path),
        fit: BoxFit.fill,
        alignment: Alignment.center,
      );
    });
    _template.img = await image!.readAsBytes();
  }

  Future<XFile?> _getFromGallery() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    return img;
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalTemplateBloc>(context).add(SaveTemplate(_template));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Article saved successfully.'),
      ),
    );
    Navigator.pushNamed(context, '/templates', arguments: _template);
  }
}
