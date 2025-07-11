import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/dive.dart';

class DiveDetailScreen extends StatefulWidget {
  final Dive dive;

  const DiveDetailScreen({super.key, required this.dive});

  @override
  State<DiveDetailScreen> createState() => _DiveDetailScreenState();
}

class _DiveDetailScreenState extends State<DiveDetailScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _diveOperatorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _boatController = TextEditingController();
  List<String> _diveType = ['Scuba'];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _diveOperatorController.text = widget.dive.diveOperator;
    _dateController.text = DateFormat.yMMMd().format(widget.dive.date);
    _locationController.text = widget.dive.location;
    _boatController.text = widget.dive.boat;

    // Defensive check for diveType
    if (widget.dive.diveType is List<String>) {
      _diveType = widget.dive.diveType;
    } else if (widget.dive.diveType is String) {
      // If it's a String, convert it to a List containing that string
      _diveType = [widget.dive.diveType as String];
    } else {
      // Fallback to an empty list if type is unexpected
      _diveType = [];
    }

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _diveOperatorController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    _boatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Crear registro',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar', style: TextStyle(color: Colors.blue)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save action
            },
            child: const Text('Guardar', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildGeneralInfoPage(),
                _buildDiveTypePage(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? Colors.black
                      : Colors.grey.withAlpha(128),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralInfoPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informacion General',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Rellena los siguientes campos.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildTextField(
                label: 'Operadora de buceo',
                controller: _diveOperatorController,
                hint: 'Operadora de buceo'),
            const SizedBox(height: 20),
            _buildTextField(label: 'Fecha', controller: _dateController),
            const SizedBox(height: 20),
            _buildTextField(
                label: 'Lugar del buceo',
                controller: _locationController,
                hint: '¿Dónde buceaste?'),
            const SizedBox(height: 20),
            _buildTextField(
                label: 'Buque / Instalacion', controller: _boatController),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required TextEditingController controller,
      String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDiveTypePage() {
    final diveTypes = [
      'Scuba',
      'Assist. Superficie',
      'Altura Geografica',
      'Saturacion'
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tipo de Buceo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: diveTypes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                final type = diveTypes[index];
                return _buildDiveTypeOption(title: type, value: type);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiveTypeOption({required String title, required String value}) {
    final bool isSelected = _diveType.contains(value);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _diveType.remove(value);
          } else {
            _diveType.add(value);
          }
        });
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withAlpha(25) : Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}