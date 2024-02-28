import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/core/constants/constants.dart';
import 'package:meme_generator/features/domain/entities/template.dart';
import 'package:meme_generator/features/domain/entities/text_data.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_bloc.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_event.dart';
import 'package:meme_generator/features/presentation/widgets/custom_text_field.dart';
import 'package:meme_generator/features/presentation/widgets/demotivator.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../injection_container.dart';

class EditTemplatePage extends StatefulWidget {
  final Template? initialTemplate;

  const EditTemplatePage({super.key, this.initialTemplate});

  @override
  State<EditTemplatePage> createState() => _EditTemplatePageState();
}

class _EditTemplatePageState extends State<EditTemplatePage> {
  late final Template _template;
  final _screenshotController = ScreenshotController();

  Image? _image;

  @override
  void initState() {
    super.initState();

    _template = widget.initialTemplate ?? defaultTemplate;
    if (_template.img != null) {
      _image = Image.memory(_template.img!);
    }
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_back),
            onPressed: context.pop,
          ),

        ),
        // drawer: const MyDrawer(),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'shareBtn',
              onPressed: _takeScreenshot,
              child: const Icon(Icons.share),
            ),
            const SizedBox(width: 10,),
            Builder(builder: (context) {
              return FloatingActionButton(
                heroTag: 'saveBtn',
                onPressed: () => _onFloatingActionButtonPressed(context),
                child: const Icon(Icons.save),
              );
            }),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ListView(
              children: [
                ...[
                  Screenshot(
                    controller: _screenshotController,
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: Demotivator(
                          onTap: _setGalleryImage,
                          template: _template,
                          child: _image ?? const Column()),
                    ),
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
            setState(
              () {
                _template.textList[index].text = data;
              },
            );
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
    if (_template.id == null) {
      BlocProvider.of<LocalTemplateBloc>(context).add(SaveTemplate(_template));
    } else {
      BlocProvider.of<LocalTemplateBloc>(context)
          .add(UpdateTemplate(_template));
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Template saved successfully.'),
      ),
    );
    context.pushNamed('templates');
  }

  _takeScreenshot() async {
    final imgFile = await _screenshotController.capture();
    Share.shareXFiles([XFile.fromData(imgFile!, mimeType: '.jpg')]);
  }
}
