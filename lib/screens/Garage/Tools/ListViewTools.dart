import 'package:flutter/material.dart';
import 'package:locagest/screens/Garage/Tools/ModifyTools.dart';
import 'package:toast/toast.dart';

// Define a data class for the image data
class ImageData {
  final String imagePath;
  final String name;
  final String marque;
  final String stock;

  ImageData({
    required this.imagePath,
    required this.name,
    required this.marque,
    required this.stock,
  });
}

class ListViewDemo extends StatelessWidget {
  const ListViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a list of ImageData objects
    List<ImageData> imageDataList = [
      ImageData(
        imagePath: "assets/images/eau.png",
        name: "eau de radiateur",
        marque: "Bosh",
        stock: "5",
      ),
      ImageData(
        imagePath: "assets/images/phare.jpg",
        name: "phare voiture",
        marque: "valeo",
        stock: "5",
      ),
      ImageData(
        imagePath: "assets/images/pneu.jpg",
        name: "Pneau voiture",
        marque: "Mechlen",
        stock: "5",
      ),
      // add more images here...
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Listes des tools"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade400,
              const Color.fromARGB(255, 223, 223, 227),
            ],
          ),
        ),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: 400,
            height: 500,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Create a ListView widget with the list of ImageData objects
                    Expanded(
                      child: ListView.builder(
                        itemCount: imageDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final imageData = imageDataList[index];
                          return Dismissible(
                            key: Key(imageData.name),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Colors.green,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(
                                Icons.update,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                // Update action
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ModifyToolsScreen(),
                                  ),
                                );
                              } else if (direction == DismissDirection.startToEnd) {
                                // Delete action
                                Toast.show(
                                  'Delete: ${imageData.name}',
                                  duration: Toast.lengthShort,
                                  gravity: Toast.bottom,
                                );
                                imageDataList.removeAt(index);
                              }
                            },
                            child: ListTile(
                              leading: Image.asset(imageData.imagePath),
                              title: Text(imageData.name),
                              subtitle: Text(imageData.marque),
                              trailing: Text(imageData.stock),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
