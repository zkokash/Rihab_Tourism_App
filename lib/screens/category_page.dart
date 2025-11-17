import 'package:flutter/material.dart';
import '/models/monument.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryPage extends StatefulWidget {
  final String category; /////////////////////////////
  CategoryPage({required this.category}); /////////////////////
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  void _launchMaps(double lat, double lon) async {
    final String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$lon";
    await launchUrl(Uri.parse(googleMapsUrl));
  }

  List<Monument> getMonuments() {
    switch (widget.category) {
      case 'churches':
        return [
          Monument(
            name: 'Church of St. George',
            description:
                """It is one of the oldest historical churches in the world,
and it was a cave in which a Christian group worshiped in secret for fear
of the oppression of the pagan Roman state.""",
            imagePath: 'assets/images/churches.jpg',
            latitude: 32.32166,
            longitude: 36.09681,
            imagePath1: 'assets/images/c1-1.jpg',
            imagePath2: 'assets/images/c1-2.jpg',
            imagePath3: 'assets/images/c1-3.jpg',
          ),
          Monument(
            name: 'Church of St. Mary',
            description:
                """It is one of the oldest historical churches in the world,
and it was a cave in which a Christian group worshiped in secret for fear
of the oppression of the pagan Roman state.""",
            imagePath: 'assets/images/cemeteries.jpg',
            latitude: 32.32166,
            longitude: 36.09681,
            imagePath1: 'assets/images/c1-1.jpg',
            imagePath2: 'assets/images/c1-2.jpg',
            imagePath3: 'assets/images/c1-3.jpg',
          ),
        ];
      case 'cemeteries':
        return [];
      case 'water_wells':
        return [];
      case 'caves':
        return [];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Monument> monuments = getMonuments();
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: SafeArea(
        child: ListView.builder(
          itemCount: monuments.length,
          itemBuilder: (context, index) {
            final monument = monuments[index];
            return Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      monument.imagePath,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    children: [
                      largerImage(context, monument.imagePath1),
                      largerImage(context, monument.imagePath2),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          monument.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          monument.description,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.map),
                    onPressed: () =>
                        _launchMaps(monument.latitude, monument.longitude),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget largerImage(context, String monument) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () =>
                  Navigator.of(context).pop(), // Close the dialog when clicked
              child: Image.asset(monument, height: 300),
            ),
          );
        },
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Image.asset(monument, height: 50),
      ),
    );
  }
}
