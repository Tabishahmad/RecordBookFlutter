import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:first_flutter/database/DatabaseHelper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _dataList = [];

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  void _getDataFromDatabase() async {
    List<Map<String, dynamic>> data = await DatabaseHelper.fetchData();
    setState(() {
      _dataList = data;
    });
  }

  void _showDialog() {
    String itemName = "";
    String itemPrice = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  itemName = value;
                },
                decoration: InputDecoration(labelText: "Item Name"),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  itemPrice = value;
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                decoration: InputDecoration(labelText: "Item Price"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                print('inside add click');
                String datetime = DateTime.now().toString();
                print('inside datetime ' + datetime);
                await DatabaseHelper.insertData(datetime, itemName, double.tryParse(itemPrice) ?? 0.0);
                Navigator.of(context).pop(); // Dismiss the dialog after saving
                print('inside datetime 2 ' + datetime);
                _getDataFromDatabase(); // Refresh the list after adding the data
                print('inside datetime  2' + datetime);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int days = 30;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog"),
      ),
      body: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Item Name: ${_dataList[index]['item_name']}"),
            subtitle: Text("Item Price: ${_dataList[index]['item_price']}"),
            trailing: Text("Date: ${_dataList[index]['datetime']}"),
          );
        },
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
