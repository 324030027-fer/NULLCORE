import 'package:flutter/material.dart';
import '/models/map_location.dart';

class LocationEditor extends StatefulWidget {
  final MapLocation location;

  const LocationEditor({super.key, required this.location});

  @override
  State<LocationEditor> createState() => _LocationEditorState();
}

class _LocationEditorState extends State<LocationEditor> {
  late TextEditingController titleController;
  late TextEditingController descController;
  late TextEditingController asset360Controller;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.location.title);
    descController = TextEditingController(text: widget.location.description);
    asset360Controller = TextEditingController(text: widget.location.assetImage360);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    asset360Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Editar Ubicación",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Título"),
              ),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Descripción"),
              ),
              TextField(
                controller: asset360Controller,
                decoration:
                    const InputDecoration(labelText: "Ruta 360 (assetImage360)"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.location.title = titleController.text;
                  widget.location.description = descController.text;
                  widget.location.assetImage360 = asset360Controller.text;

                  Navigator.pop(context, widget.location);
                },
                child: const Text("Guardar cambios"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
