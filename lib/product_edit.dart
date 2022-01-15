import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './main.dart';

class ProductEdit extends StatefulWidget {
  final List products;
  final int index;

  ProductEdit({this.products, this.index});

  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  TextEditingController controllerName;
  TextEditingController controllerPrice;
  TextEditingController controllerStock;
  TextEditingController controllerID;
  TextEditingController controllerEmp;

  editProduct() {
    var url = 'https://hassanhealthcare.com/school_edit1.PHP';
    http.post(url, body: {
      "School_ID": widget.products[widget.index]["School_ID"],
      "School_Site_A": controllerName.text,
      "City": controllerPrice.text,
      "note": controllerStock.text,
      "emp": controllerEmp.text
    });
  }

  @override
  void initState() {
    controllerName = TextEditingController(
        text: widget.products[widget.index]["School_Site_A"]);
    controllerPrice =
        TextEditingController(text: widget.products[widget.index]["City"]);
    controllerStock =
        TextEditingController(text: widget.products[widget.index]["note"]);
    controllerID =
        TextEditingController(text: widget.products[widget.index]["School_ID"]);
    controllerEmp =
        TextEditingController(text: widget.products[widget.index]["name"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("School Edit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      hintText: "School Name", labelText: "School Name"),
                  controller: controllerName,
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
                  decoration: InputDecoration(hintText: "ID", labelText: "ID"),
                  controller: controllerID,
                ),
                TextField(
                  decoration:
                      InputDecoration(hintText: "emp", labelText: "emp"),
                  controller: controllerEmp,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                RaisedButton(
                  child: Text("Edit School"),
                  color: Colors.indigo[900],
                  onPressed: () {
                    editProduct();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Home();
                      },
                    ));
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
