import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPackagePage extends StatefulWidget {
  const AddPackagePage({Key? key}) : super(key: key);

  @override
  State<AddPackagePage> createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _item1PriceController = TextEditingController();
  final TextEditingController _item1UrlController = TextEditingController();
  final TextEditingController _item1NameController = TextEditingController();
  final TextEditingController _item2PriceController = TextEditingController();
  final TextEditingController _item2UrlController = TextEditingController();
  final TextEditingController _item2NameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  List<TextEditingController> _textFieldControllers = [];
  int _iconButtonPressCount = 0;

  // List of label texts for the new TextFormField
  List<String> _labelTexts = [
    'Price',
    'Image URL',
    'Name',
  ];

  void _addFields() {
    setState(() {
      _iconButtonPressCount++; // Increment the count
      // Add three sets of text editing fields
      _textFieldControllers.addAll([
        TextEditingController(), // Description
        TextEditingController(), // Image URL
        TextEditingController(), // Item Price 1
      ]);
    });
  }

  void _saveToFirestore() {
    // Get all the values from the controllers
    String description = _descriptionController.text;
    String imageUrl = _imageUrlController.text;
    String item1Price = _textFieldControllers[0].text;
    String item1Url = _textFieldControllers[1].text;
    String item1Name = _textFieldControllers[2].text;
    String item2Price = _textFieldControllers[3].text;
    String item2Url = _textFieldControllers[4].text;
    String item2Name = _textFieldControllers[5].text;
    String name = _nameController.text;
    String price = _priceController.text;
    String rate = _rateController.text;

    // Add the data to Firestore
    FirebaseFirestore.instance.collection('shop_admin').add({
      'description': description,
      'imageUrl': imageUrl,
      'item1Price': item1Price,
      'item1Url': item1Url,
      'item1Name': item1Name,
      'item2Price': item2Price,
      'item2Url': item2Url,
      'item2Name': item2Name,
      'name': name,
      'price': price,
      'rate': rate,
    }).then((_) {
      // Reset the text fields after saving
      _descriptionController.clear();
      _imageUrlController.clear();
      _textFieldControllers[0].clear();
      _textFieldControllers[1].clear();
      _textFieldControllers[2].clear();
      _textFieldControllers[3].clear();
      _textFieldControllers[4].clear();
      _textFieldControllers[5].clear();
      _nameController.clear();
      _priceController.clear();
      _rateController.clear();

      // Reset the dynamic text field controllers
      _textFieldControllers.clear();
      _iconButtonPressCount = 0;

      setState(() {});

      // Show a snackbar or navigate to a new screen indicating success
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved successfully')));
    }).catchError((error) {
      // Handle any errors that occur during the save process
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Package'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Print the icon button press count
              Text(
                'Icon Button Press Count: $_iconButtonPressCount',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              //Name
              Text(
                'Name:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter name',
                ),
              ),
              SizedBox(height: 20),
              //Description
              Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                ),
              ),
              SizedBox(height: 20),
              //Image URL:
              Text(
                'Image URL:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  hintText: 'Enter image URL',
                ),
              ),
              SizedBox(height: 20),
              //Price
              Text(
                'Price:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: 'Enter price',
                ),
              ),
              SizedBox(height: 20),
              //Rate
              Text(
                'Rate:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _rateController,
                decoration: InputDecoration(
                  hintText: 'Enter recommended rate',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Item Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // Text editing fields for each input
              for (var i = 0; i < _textFieldControllers.length; i++)
                TextFormField(
                  controller: _textFieldControllers[i],
                  decoration: InputDecoration(
                    labelText: 'Enter item${_iconButtonPressCount} ${_labelTexts[i % _labelTexts.length]}',
                  ),
                ),
              SizedBox(height: 20),
              // Add button to add new fields
              IconButton(
                onPressed: _addFields,
                icon: Icon(Icons.add),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveToFirestore,
                child: Text('Save'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

