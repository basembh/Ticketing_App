import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product_edit.dart';
import './main.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatefulWidget {
  List products;
  int index;
  Double lat;
  Double long;

  ProductDetail({this.index, this.products});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    //latitude = ${widget.products[widget.index]["Lat"]};
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class _ProductDetailState extends State<ProductDetail> {
  deleteProduct() {
    var url = 'https://hassanhealthcare.com/school_delete.php';
    http.post(url, body: {'id': widget.products[widget.index]["School_ID"]});
  }

  void confirm() {
    AlertDialog confirm = AlertDialog(
      content: Text(
          "Are you sure you want to delete ${widget.products[widget.index]["name"]}?"),
      actions: <Widget>[
        RaisedButton(
            child: Text(
              'Accept',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
            onPressed: () {
              deleteProduct();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return Home();
              }));
            }),
        RaisedButton(
            child: Text("Cancel"),
            color: Colors.white70,
            onPressed: () => Navigator.pop(context))
      ],
    );

    showDialog(context: context, builder: (_) => confirm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.products[widget.index]["School_Site_A"]}"),
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        height: 250.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Expanded(
              child: Column(
                //mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                  ),
                  Text(
                    "Emp: " + widget.products[widget.index]["name"],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "ID: ${widget.products[widget.index]["School_ID"]}" +
                        " -- " +
                        "City: ${widget.products[widget.index]["City"]}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "الملاحظة : ${widget.products[widget.index]["note"]}",
                    style: TextStyle(fontSize: 18.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    //textAlign: RichText(text: text),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Edit"),
                          color: Colors.indigo[900],
                          onPressed: () {
                            return Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => ProductEdit(
                                      products: widget.products,
                                      index: widget.index,
                                    )));
                          },
                        ),
                        RaisedButton(
                          child: Text("Delete"),
                          color: Colors.red,
                          onPressed: () => confirm(),
                        ),
                        RaisedButton(
                          child: Text("Map"),
                          color: Colors.green,
                          onPressed: () =>
                              //                        MapUtils.openMap(-3.823216,-38.481700);
                              MapUtils.openMap(
                                  double.parse(
                                      widget.products[widget.index]["Lat"]),
                                  double.parse(
                                      widget.products[widget.index]["Long"])),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
