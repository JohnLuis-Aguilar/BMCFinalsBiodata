import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TextInputPage(),
    );
  }
}

class TextInputPage extends StatefulWidget {
  const TextInputPage({super.key});

  @override
  State<TextInputPage> createState() => _TextInputPageState();
}

class _TextInputPageState extends State<TextInputPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController placeOfBirthController =
      TextEditingController();
  final TextEditingController civilStatusController =
      TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController emergencyPersonController =
      TextEditingController();
  final TextEditingController emergencyNumberController =
      TextEditingController();

  late final List<_BiodataField> fields = [
    _BiodataField('Name', 'First Name, Middle Name, Last Name',
        nameController),
    _BiodataField('Age', 'Input your age', ageController,
        keyboardType: TextInputType.number),
    _BiodataField('Gender', 'Male or Female', genderController),
    _BiodataField('Address',
        'House No., Street, Barangay, City, Province', addressController),
    _BiodataField('Contact Number', 'Input your contact number',
        contactController,
        keyboardType: TextInputType.phone),
    _BiodataField('Email Address', 'Input your email address',
        emailController,
        keyboardType: TextInputType.emailAddress),
    _BiodataField(
        'Birthday', 'Input your birthday', birthdayController),
    _BiodataField('Place of Birth', 'Input your place of birth',
        placeOfBirthController),
    _BiodataField('Civil Status',
        'Single, Married, Widowed, Separated, Divorced',
        civilStatusController),
    _BiodataField('Height', 'Input your height', heightController,
        keyboardType: TextInputType.numberWithOptions(decimal: true)),
    _BiodataField('Weight', 'Input your weight', weightController,
        keyboardType: TextInputType.numberWithOptions(decimal: true)),
    _BiodataField(
        'Language Spoken', 'Input your language spoken', languageController),
    _BiodataField('Emergency Contact Person',
        'Input your emergency contact person', emergencyPersonController),
    _BiodataField('Emergency Contact Number',
        'Input your emergency contact number', emergencyNumberController,
        keyboardType: TextInputType.phone),
  ];

  List<String> displayedLines = [];

  void displayText() {
    setState(() {
      displayedLines = [
        for (final field in fields)
          if (field.controller.text.trim().isNotEmpty)
            '${field.label}: ${field.controller.text.trim()}',
      ];
    });
  }

  @override
  void dispose() {
    for (final field in fields) {
      field.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biodata Form'),
        backgroundColor: const Color.fromARGB(255, 8, 201, 20),
        foregroundColor: const Color.fromARGB(255, 225, 225, 225),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final field in fields) ...[
                Text(
                  field.label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: field.controller,
                  keyboardType: field.keyboardType,
                  decoration: InputDecoration(
                    labelText: field.hint,
                    border: const OutlineInputBorder(),
                    prefix: const Icon(Icons.edit),
                  ),
                ),
                const SizedBox(height: 10),
              ],
              const SizedBox(height: 6),
              ElevatedButton(
                onPressed: displayText,
                child: const Text('Display Text'),
              ),
              const SizedBox(height: 30),
              const Text('Output',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              if (displayedLines.isEmpty)
                const Text(
                  'No text entered yet',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 3, 114, 27)),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final line in displayedLines)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          line,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 3, 114, 27)),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BiodataField {
  const _BiodataField(this.label, this.hint, this.controller,
      {this.keyboardType});

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
}
