import 'package:flutter/material.dart';
import 'main.dart'; // Importation de la classe Candidate depuis main.dart

class CandidateForm extends StatelessWidget {
  final Function(CandidateForm) onCandidateAdded;

  CandidateForm({
    required this.onCandidateAdded,
  });

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController partyController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Formulaire'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Nom'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir un nom';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir une description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: partyController,
                    decoration: InputDecoration(labelText: 'Parti politique'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir un parti politique';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: imageUrlController,
                    decoration: InputDecoration(labelText: 'URL de la photo'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir une URL de photo';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        CandidateForm candidate = CandidateForm(onCandidateAdded: onCandidateAdded); (
                          name: nameController.text,
                          description: descriptionController.text,
                          party: partyController.text,
                          imageUrl: imageUrlController.text,
                        );
                        onCandidateAdded(candidate);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Valider'),
                  ),
                ],
              ),
            ),
            ),
        );
    }
}
