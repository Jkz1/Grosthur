import 'package:flutter/material.dart';

class DataGrosThur extends ChangeNotifier{
  List<dynamic> _keranjang = [];
  List<Map<String, dynamic>> _item = [
    {'nama': 'Beras', 'harga': 15000},
    {'nama': 'Minyak Goreng', 'harga': 10000},
    {'nama': 'Gula', 'harga': 12000},
    {'nama': 'Telur', 'harga': 2000},
    {'nama': 'Tepung Terigu', 'harga': 8000},
    {'nama': 'Susu', 'harga': 10000},
    {'nama': 'Kopi', 'harga': 7000},
    {'nama': 'Teh', 'harga': 5000},
    {'nama': 'Mie Instan', 'harga': 3000},
    {'nama': 'Garam', 'harga': 3000},
    {'nama': 'Lada', 'harga': 5000},
    {'nama': 'Saus Tomat', 'harga': 7000},
    {'nama': 'Bawang Merah', 'harga': 10000},
    {'nama': 'Bawang Putih', 'harga': 8000},
    {'nama': 'Kentang', 'harga': 5000},
    {'nama': 'Wortel', 'harga': 4000},
    {'nama': 'Cabai Merah', 'harga': 6000},
    {'nama': 'Cabai Hijau', 'harga': 6000},
    {'nama': 'Ikan Teri', 'harga': 4000},
    {'nama': 'Ikan Asin', 'harga': 10000},
    {'nama': 'Tahu', 'harga': 3000},
    {'nama': 'Tempe', 'harga': 4000},
    {'nama': 'Sarden Kaleng', 'harga': 8000},
    {'nama': 'Mie Telur', 'harga': 3500},
    {'nama': 'Keju', 'harga': 12000},
  ];

  List<dynamic> get keranjang => _keranjang;
  List<Map<String, dynamic>> get item => _item;

  set setkeranjang(val){
    _keranjang = val;
    notifyListeners();
  }

  set setitem(val){
    _item = val;
    notifyListeners();
  }

  clearkeranjang(){
    _keranjang = [];
    notifyListeners();
  }

  addkeranjang(val){
    _keranjang.add(val);
    
    notifyListeners();
  }

  ubahbayar(val, nama){
    for (var i = 0; i < _keranjang.length; i++) {
      if(_keranjang[i]["nama"] == nama){
        _keranjang[i]['jumlahBayar'] = val;
      }
    }
    notifyListeners();
  }
  ubahjumlah(val, nama){
    for (var i = 0; i < _keranjang.length; i++) {
      if(_keranjang[i]["nama"] == nama){
        _keranjang[i]['jumlahItem'] = val;
      }
    }
    notifyListeners();
  }

  int total(){
    int jumlah = 0;
    for (var i = 0; i < _keranjang.length; i++) {
      jumlah += _keranjang[i]["jumlahBayar"] as int;
    }
    return jumlah;
  }

  dynamic getItemKeranjang(){
    dynamic item = [];
    for (var i = 0; i < _keranjang.length; i++){
      if(_keranjang[i]["jumlahItem"] != 0){
        item.add(_keranjang[i]);
      }
    }
    return item;
  }

}