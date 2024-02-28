import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_bloc.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_event.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_state.dart';
import 'package:meme_generator/features/presentation/widgets/demotivator.dart';
import 'package:collection/collection.dart';

import '../../../domain/entities/template.dart';
import '../../../injection_container.dart';

class TemplatesPage extends StatefulWidget {
  const TemplatesPage({super.key});

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  late bool _isDeleting;

  late Map<Template, bool> _toDelete;

  @override
  void initState() {
    super.initState();
    _isDeleting = false;
    _toDelete = HashMap();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalTemplateBloc>()..add(const GetSavedTemplates()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Welcome',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () => setState(() {
                      _isDeleting = !_isDeleting;
                    }),
                icon: Icon(
                  _isDeleting ? Icons.clear : Icons.delete,
                  color: Colors.white,
                ))
          ],
        ),
        floatingActionButton: _buildFloatingActionButton(),
        body: Center(
          child: BlocBuilder<LocalTemplateBloc, LocalTemplatesState>(
            builder: (context, state) {
              if (state.templates == null) {
                return const Center(
                  child: Text('Add something'),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 10),
                child: GridView.count(
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: state.templates!.map(_buildTemplateWidget).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    if (!_isDeleting) {
      return FloatingActionButton(
        onPressed: () {
          context.pushNamed('create');
        },
        child: const Icon(Icons.add),
      );
    } else {
      return FloatingActionButton(
        onPressed: () {
          final filteredMap = Map<Template, bool>.from(_toDelete)..removeWhere((key, value) => !value);
          List<Template> keys = filteredMap.keys.toList();
          print(keys);
        },
        child: const Icon(Icons.delete),
      );
    }
  }

  Widget _buildTemplateWidget(Template templateItem) {
    if (_toDelete[templateItem] == null) {
      _toDelete[templateItem] = false;
    }
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Demotivator(
            onTap: () {
              context.pushNamed('edit', extra: templateItem);
            },
            template: templateItem,
            child: templateItem.img != null
                ? Image.memory(templateItem.img!)
                : Container(),
          ),
        ),
        _isDeleting
            ? Container(
                alignment: AlignmentDirectional.topEnd,
                padding: const EdgeInsets.only(right: 10),
                child: Checkbox(
                  value: _toDelete[templateItem],
                  onChanged: (value) => setState(() {
                    _toDelete[templateItem] = value ?? false;
                  }),
                ))
            : Container()
      ],
    );
  }
}
