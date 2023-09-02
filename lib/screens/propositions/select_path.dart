import 'package:flutter/material.dart';

class PathSelection extends StatefulWidget {
  @override
  _PathSelectionState createState() => _PathSelectionState();
}

class _PathSelectionState extends State<PathSelection> {
  String? selectedEducationType;
  String? selectedSpecialite;
  String? selectedNiveauScolaire;
  String? selectedMatiere;
  String? selectedCours;

  List<String> educationTypes = []; // Initialize as empty
  List<String> specialites = [];
  List<String> niveauxScolaires = [];
  List<String> matieres = [];
  List<String> cours = [];

  @override
  void initState() {
    super.initState();
    // Initialize dropdown items here (e.g., from API call or other data source)
    educationTypes = ['Type 1', 'Type 2', 'Type 3'];
    specialites = ['Spécialité 1', 'Spécialité 2', 'Spécialité 3'];
    niveauxScolaires = ['Niveau 1', 'Niveau 2', 'Niveau 3'];
    matieres = ['Matière 1', 'Matière 2', 'Matière 3'];
    cours = ['Cours 1', 'Cours 2', 'Cours 3'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sélectionner le Chemin'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sélectionner les Éléments du Chemin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              _buildDropdown(
                label: 'Type d\'éducation',
                items: educationTypes,
                selectedItem: selectedEducationType,
                onChanged: (value) {
                  setState(() {
                    selectedEducationType = value;
                  });
                },
              ),
              SizedBox(height: 16),
              _buildDropdown(
                label: 'Spécialité',
                items: specialites,
                selectedItem: selectedSpecialite,
                onChanged: (value) {
                  setState(() {
                    selectedSpecialite = value;
                  });
                },
              ),
              SizedBox(height: 16),
              _buildDropdown(
                label: 'Niveau scolaire',
                items: niveauxScolaires,
                selectedItem: selectedNiveauScolaire,
                onChanged: (value) {
                  setState(() {
                    selectedNiveauScolaire = value;
                  });
                },
              ),
              SizedBox(height: 16),
              _buildDropdown(
                label: 'Matière',
                items: matieres,
                selectedItem: selectedMatiere,
                onChanged: (value) {
                  setState(() {
                    selectedMatiere = value;
                  });
                },
              ),
              SizedBox(height: 16),
              _buildDropdown(
                label: 'Cours',
                items: cours,
                selectedItem: selectedCours,
                onChanged: (value) {
                  setState(() {
                    selectedCours = value;
                  });
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  String selectedPath = '';
                  selectedPath = '$selectedEducationType/$selectedSpecialite/$selectedNiveauScolaire/$selectedMatiere/$selectedCours';
                  Navigator.pop(context, selectedPath);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(53, 21, 93, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Confirmer la Sélection',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required String? selectedItem,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton<String>(
          value: selectedItem,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          isExpanded: true,
        ),
      ],
    );
  }
}
