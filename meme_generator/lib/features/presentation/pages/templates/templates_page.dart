import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_bloc.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_event.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_state.dart';
import 'package:meme_generator/features/presentation/widgets/demotivator.dart';

import '../../../injection_container.dart';
import '../../widgets/drawer.dart';

class TemplatesPage extends StatefulWidget {
  const TemplatesPage({super.key});

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalTemplateBloc>()..add(const GetSavedTemplates()),
      child: Scaffold(
        appBar: AppBar(),
        drawer: const MyDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/create');
          },
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: BlocBuilder<LocalTemplateBloc, LocalTemplatesState>(
            builder: (context, state) {
              if (state.templates == null) {
                return const Center(
                  child: Text('Add something'),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: GridView.count(
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: state.templates!
                      .map(
                        (templateItem) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Demotivator(
                            onTap: () {
                              Navigator.pushNamed(context, '/demotivator',
                                  arguments: templateItem);
                            },
                            template: templateItem,
                            child: templateItem.img != null
                                ? Image.memory(templateItem.img!)
                                : Container(),
                          ),
                        ),
                      ).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
