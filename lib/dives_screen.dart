import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/dive.dart';
import 'dive_detail_screen.dart';

class DivesScreen extends StatefulWidget {
  const DivesScreen({super.key});

  @override
  State<DivesScreen> createState() => _DivesScreenState();
}

class _DivesScreenState extends State<DivesScreen> {
  int _selectedIndex = 0;

  final List<Dive> dives = [
    Dive(location: 'Cozumel, Mexico', date: DateTime(2024, 5, 15)),
    Dive(location: 'Great Barrier Reef, Australia', date: DateTime(2024, 6, 22)),
    Dive(location: 'Red Sea, Egypt', date: DateTime(2024, 7, 10)),
    Dive(location: 'Blue Hole, Belize', date: DateTime(2023, 11, 30)),
    Dive(location: 'Galapagos Islands, Ecuador', date: DateTime(2023, 9, 5)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      // Dives List View
      Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Listado de Buceos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: dives.length,
              itemBuilder: (context, index) {
                final dive = dives[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiveDetailScreen(dive: dive),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: const Icon(Icons.scuba_diving),
                    title: Text(dive.location),
                    subtitle: Text(DateFormat.yMMMd().format(dive.date)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ],
      ),
      // Settings View
      const Center(
        child: Text(
          'Configuracion',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('DiveLog'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.scuba_diving),
            label: 'Buceos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuracion',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
