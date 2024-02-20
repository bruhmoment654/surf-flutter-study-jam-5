import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/core/constants/constants.dart';
import 'package:meme_generator/features/presentation/widgets/custom_text_field.dart';
import 'package:meme_generator/features/presentation/widgets/demotivator.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../domain/entities/template.dart';

class DemotivatorPage extends StatefulWidget {
  const DemotivatorPage({super.key, this.template});

  final Template? template;

  @override
  State<DemotivatorPage> createState() => _DemotivatorPageState();
}

class _DemotivatorPageState extends State<DemotivatorPage> {
  final _imageLinkTextController = TextEditingController();
  final _demTextController = TextEditingController();

  final _screenshotController = ScreenshotController();

  String? _text;

  Widget? _image;

  @override
  void initState() {
    super.initState();
    _setNetworkImage();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: _buildShareFloatingButton(),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 120),
          child: SizedBox(
            child: ListView(
              children: [
                Screenshot(
                  controller: _screenshotController,
                  child: Demotivator(
                    text: _text,
                    controller: _screenshotController,
                    onTap: _setGalleryImage,
                    template: widget.template ?? defaultTemplate,
                    child: _image ?? Image.asset('assets/img/rock.jpg'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildForm() {
    return SizedBox(
      width: 400,
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              //Image link
              OutlinedTextFormField(
                hintText: 'URL',
                controller: _imageLinkTextController,
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(
                height: 20,
              ),

              //Create btn
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                      onPressed: () => _setNetworkImage(),
                      child: const Text('Get From URL')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _setNetworkImage() {
    setState(() {
      _image = CachedNetworkImage(
        fit: BoxFit.fill,
        alignment: Alignment.center,
        imageUrl: _imageLinkTextController.text,
        placeholder: (context, _) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, _, __) => Image.asset('assets/img/rock.jpg'),
      );
    });
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
  }

  Future<XFile?> _getFromGallery() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    return img;
  }

  _buildShareFloatingButton() {
    return FloatingActionButton(
      onPressed: _takeScreenshot,
      child: const Icon(Icons.share),
    );
  }

  _takeScreenshot() async {
    final imgFile = await _screenshotController.capture();
    Share.shareXFiles([XFile.fromData(imgFile!, mimeType: '.jpg')]);
  }
}
