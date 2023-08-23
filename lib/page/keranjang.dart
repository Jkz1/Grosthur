import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grosthur/prov.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../component/itemKeranjang.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp. ');

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<DataGrosThur>(context);
    return Stack(
      children: [
        prov.keranjang.length == 0
            ? Center(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.4)),
                      padding: EdgeInsets.all(30),
                      child: Text(
                        "Keranjang kosong",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                    child: Column(
                  children: List.generate(prov.keranjang.length,
                      (index) => ItemKeranjang(data: prov.keranjang[index])),
                )),
              ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total "),
                          Text(prov.total() == 0
                              ? "Rp. 0"
                              : currencyFormatter.format(prov.total())),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5, bottom: 5),
                      child: ElevatedButton(
                        onPressed: prov.getItemKeranjang().length == 0
                            ? null
                            : () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Konfirmasi"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                                Divider(
                                                  color: Colors.grey,
                                                  height: 1.5,
                                                )
                                              ] +
                                              List.generate(
                                                  prov.getItemKeranjang().length,
                                                  (index) => Container(
                                                        margin:
                                                            EdgeInsets.symmetric(
                                                                vertical: 5),
                                                        child: ListTile(
                                                          tileColor: const Color
                                                                  .fromARGB(
                                                              255, 233, 127, 163),
                                                          title: Text(
                                                              "${prov.getItemKeranjang()[index]["nama"]}"),
                                                          trailing: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  "${prov.getItemKeranjang()[index]["jumlahItem"]} * ${currencyFormatter.format(prov.getItemKeranjang()[index]["harga"])}"),
                                                              Text(
                                                                  "${currencyFormatter.format(prov.getItemKeranjang()[index]["jumlahBayar"])}")
                                                            ],
                                                          ),
                                                        ),
                                                      )) +
                                              [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Divider(
                                                  color: Colors.grey,
                                                  height: 1.5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                        "Total keseluruhan : ${currencyFormatter.format(prov.total())}")
                                                  ],
                                                )
                                              ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {},
                                              child: Text("Cancel")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                showDialog(context: context, builder: (context){
                                                  return AlertDialog(
                                                    content: Text("Check Out Berhasil"),
                                                    actions: [
                                                      ElevatedButton(onPressed: (){
                                                        Navigator.pop(context);
                                                      }, child: Text("Back"))
                                                    ],
                                                  );
                                                });
                                                print(prov.getItemKeranjang());
                                                prov.clearkeranjang();
                                              },
                                              child: Text("Okay"))
                                        ],
                                      );
                                    });
                              },
                        child: Text("Checkout"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
