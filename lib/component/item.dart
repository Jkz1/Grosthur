import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grosthur/prov.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Item01 extends StatelessWidget {
  dynamic data;
  Item01({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.5),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withOpacity(0.2)
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  child: Image.asset(
                    'assets/beras.png',
                    width: 100,
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Text(data["nama"], maxLines: 4, textAlign: TextAlign.center,)),
                    Expanded(child: Text("${data["harga"]/1000}k/kg",  textAlign: TextAlign.center)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemZoom extends StatefulWidget {
  dynamic data;
  ItemZoom({super.key, required this.data});

  @override
  State<ItemZoom> createState() => _ItemZoomState();
}

class _ItemZoomState extends State<ItemZoom> {
  int jumlah = 0;
  int harga = 0;

  var jumlahcontroller = TextEditingController();

  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp. ');

  @override
  void initState() {
    // TODO: implement initState
    jumlahcontroller.text = '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<DataGrosThur>(context);
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      color: Colors.amber,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/beras.png',
                width: 200,
              )),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("Tambahkan ke keranjang"), Text("Total")],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: jumlah == 0
                              ? null
                              : () {
                                  setState(() {
                                    jumlah--;
                                    jumlahcontroller.text =
                                        (int.parse(jumlahcontroller.text) - 1)
                                            .toString();
                                  });
                                },
                          icon: const Icon(Icons.remove)),
                      SizedBox(
                        width: 20,
                        child: TextField(
                          onChanged: (val) {
                            if (val == '') {
                              jumlah = 0;
                              }
                              else{
                                jumlah = int.parse(val);
                              }
                              setState(() {});
                          },
                          controller: jumlahcontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if(jumlahcontroller.text == ''){
                              jumlahcontroller.text = '0';
                            }
                            setState(() {
                              jumlah++;
                              jumlahcontroller.text =
                                  (int.parse(jumlahcontroller.text) + 1)
                                      .toString();
                            });
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                  Text(currencyFormatter.format(jumlah * widget.data["harga"]))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: jumlah == 0
                      ? null
                      : () {
                        prov.addkeranjang({
                          "nama" : widget.data["nama"],
                          "jumlahItem" : jumlah,
                          "jumlahBayar" : jumlah*widget.data["harga"],
                          "harga" : widget.data["harga"]
                        });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Berhasil menambahkan ke keranjang")));
                        },
                  child: const Text("Save"))
            ],
          )
        ],
      ),
    );
  }
}
