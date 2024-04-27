import 'package:flutter/material.dart';
import 'main.dart'; // Importation de la classe Candidate depuis main.dart
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class CandidateForm extends StatefulWidget {
  final Function(CandidateForm) onCandidateAdded;

  CandidateForm({
    required this.onCandidateAdded,
  });

  @override
  _CandidateFormState createState() => _CandidateFormState();
}

class _CandidateFormState extends State<CandidateForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController partyController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  // Variable pour stocker l'image sélectionnée
  XFile? _image;

  // Méthode pour sélectionner une image depuis la galerie
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
        imageUrlController.text = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: _image == null
                    ? Icon(Icons.add_a_photo)
                    : Image.file(
                  File(_image!.path),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(
                      controller: nameController,
                      labelText: 'Nom',
                      icon: Icons.person,
                    ),
                    _buildInputField(
                      controller: descriptionController,
                      labelText: 'Description',
                      icon: Icons.info,
                    ),
                    _buildInputField(
                      controller: partyController,
                      labelText: 'Parti politique',
                      icon: Icons.flag,
                    ),
                    // Ajout de la date de session (à implémenter)
                    _buildInputField(
                      controller: TextEditingController(), // À remplacer par le contrôleur de la date
                      labelText: 'Date de session',
                      icon: Icons.calendar_today,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Candidate candidate = Candidate(
                            name: nameController.text,
                            description: descriptionController.text,
                            party: partyController.text,
                            imageUrl: imageUrlController.text,
                          );
                          widget.onCandidateAdded(candidate);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text('Sauvegarder'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez saisir $labelText';
          }
          return null;
          },
        );
    }
}
