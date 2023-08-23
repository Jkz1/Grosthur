import 'package:flutter/material.dart';
import 'package:grosthur/page/about.dart';
import 'package:grosthur/page/keranjang.dart';
import 'package:grosthur/prov.dart';
import 'package:provider/provider.dart';
import 'component/item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  @override
  void initState() {
    super.initState();
    }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<DataGrosThur>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("GosThur"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Home"),
              ),
              Tab(
                child: Text("Keranjang"),
              ),
              Tab(
                child: Text("About"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/1.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: GridView.count(
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                crossAxisCount: 2,
                children: List.generate(
                    25,
                    (index) => GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ItemZoom(data: prov.item[index]);
                                });
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              child: Item01(data: prov.item[index])),
                        )),
              ),
            ),
            Container(
              decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/2.jpg"),
          fit: BoxFit.fill,
        ),
        ),
              child: KeranjangPage()),
            Container(
              decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/3.jpg"),
          fit: BoxFit.fill,
        ),
        ),
              child: About()
            ),
          ],
        ),
      ),
    );
  }
}
