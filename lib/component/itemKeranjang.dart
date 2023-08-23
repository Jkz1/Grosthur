import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grosthur/prov.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ItemKeranjang extends StatefulWidget {
  dynamic data;
  ItemKeranjang({super.key, required this.data});

  @override
  State<ItemKeranjang> createState() => _ItemKeranjangState();
}

class _ItemKeranjangState extends State<ItemKeranjang> with SingleTickerProviderStateMixin {

 
  TextStyle TextBlackWhite() {
    return TextStyle(
        color: jumlah == 0 ? Colors.white : Colors.black,
        fontFamily: "QSandBold");
  }

  final jumlahcontroller = TextEditingController();

  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp. ');

  int jumlahtotal = 0;

  int jumlah = 0;

  @override
  void initState() {
    // TODO: implement initState
    jumlahcontroller.text = widget.data["jumlahItem"].toString();
    jumlah = widget.data["jumlahItem"];
    jumlahtotal = widget.data["jumlahBayar"];
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    jumlahtotal = jumlah * widget.data["harga"] as int;
    Provider.of<DataGrosThur>(context, listen: false)
        .ubahbayar(jumlahtotal, widget.data["nama"]);
    Provider.of<DataGrosThur>(context, listen: false)
        .ubahjumlah(jumlah, widget.data["nama"]);

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                  color: jumlah == 0 ? Colors.red : Colors.blue, width: 1.5),
              borderRadius: BorderRadius.circular(12),
              color: jumlah == 0
                  ? Colors.pink.withOpacity(0.5)
                  : Colors.lightBlue.withOpacity(0.5)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/beras.png', width: 100),
              AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 500),
                style: TextBlackWhite(),
                child: Text(
                  widget.data['nama'],
                  style: TextBlackWhite(),
                ),
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12)

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: jumlah == 0
                                ? null
                                : () {
                                    jumlah--;
                                    jumlahcontroller.text =
                                        (int.parse(jumlahcontroller.text) - 1)
                                            .toString();
                                    setState(() {});
                                  },
                            icon: Icon(Icons.remove, color: jumlah == 0? Colors.grey:Colors.black,)),
                        SizedBox(
                          width: 15,
                          child: AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 500),
                            style: TextBlackWhite(),
                            child: TextField(
                              onChanged: (val) {
                                if (val == '') {
                                  jumlah = 0;
                                } else {
                                  jumlah = int.parse(val);
                                }
                                setState(() {});
                              },
                              controller: jumlahcontroller,
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (jumlahcontroller.text == '') {
                                jumlahcontroller.text = '0';
                              }
                              jumlah++;
                              jumlahcontroller.text =
                                  (int.parse(jumlahcontroller.text) + 1)
                                      .toString();
                              setState(() {});
                            },
                            icon: Icon(Icons.add, color: Colors.black,)),
                      ],
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 500),
                      style: TextBlackWhite(),
                      child: Text(
                        currencyFormatter.format(jumlah * widget.data["harga"]),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
