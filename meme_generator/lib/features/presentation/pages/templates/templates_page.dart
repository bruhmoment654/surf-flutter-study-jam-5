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
          onPressed: (){
            Navigator.pushNamed(context, '/create');
          },
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: BlocBuilder<LocalTemplateBloc, LocalTemplatesState>(
            builder: (context, state) {
              if (state.templates == null){
                return const Center(
                  child: Text('Add something'),
                );
              }
              return CarouselSlider(
                options: CarouselOptions(height: 350),
                items: state.templates
                    ?.map((templateItem) => Builder(
                          builder: (context) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: Demotivator(
                                onTap: () {
                                  Navigator.pushNamed(context, '/demotivator',
                                      arguments: templateItem);
                                },
                                template: templateItem,
                                child: Image.network(
                                    templateItem.uriToImage ?? ''),
                              )),
                        ))
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
