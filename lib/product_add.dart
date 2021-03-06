import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductAdd extends StatefulWidget {
  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  // TextEditingController controllerID = new TextEditingController();
  TextEditingController controllerID = new TextEditingController();
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerPrice = new TextEditingController();
  TextEditingController controllerStock = new TextEditingController();
  TextEditingController controllerEmp = new TextEditingController();

  addProduct() {
    var postRoute = "https://hassanhealthcare.com/schools_post.php";
    http.post(postRoute, body: {
      "id": controllerID.text,
      "name": controllerName.text,
      "price": controllerPrice.text,
      "stock": controllerStock.text,
      "emp": controllerEmp.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New School"),
        backgroundColor: Colors.indigo[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                // TextField(
                //   decoration: InputDecoration(
                //       hintText: "Product ID", labelText: "Product ID"),
                // ),
                TextField(
                  decoration:
                      InputDecoration(hintText: "Name", labelText: "Name"),
                  controller: controllerName,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "ID", labelText: "ID"),
                  controller: controllerID,
                ),
                TextField(
                  decoration:
                      InputDecoration(hintText: "City", labelText: "City"),
                  controller: controllerPrice,
                ),
                TextField(
                  decoration:
                      InputDecoration(hintText: "Note", labelText: "Note"),
                  controller: controllerStock,
                ),
                TextField(
                  decoration:
                      InputDecoration(hintText: "Emp", labelText: "Emp"),
                  controller: controllerEmp,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                RaisedButton(
                  child: Text("Add School"),
                  color: Colors.indigo[900],
                  onPressed: () {
                    addProduct();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
