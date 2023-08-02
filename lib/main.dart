import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'apiservice.dart';


void main() {
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  OpenseaController openseaController = Get.put(OpenseaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('opensea Api')),
        body: Obx(
              () => openseaController.isLoading.value
              ? Center(
            child: CircularProgressIndicator(),
          )
              :Container(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemCount: openseaController.resp!.products.length ,
                    itemBuilder: (context, index) {
                    var prdts=openseaController.resp!.products[index];
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${prdts.title}",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),),
                            Text("Description : ${openseaController.resp?.products[index].description}"),
                            Text("Price : ${openseaController.resp?.products[index].price.toString()}"),
                            Text("Brand : ${openseaController.resp?.products[index].brand}"),
                            Text("Category : ${openseaController.resp?.products[index].category}"),
                            Text("Stock Available: ${openseaController.resp?.products[index].stock}"),Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network("${openseaController.resp!.products[index].thumbnail}"),
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  itemCount: openseaController.resp!.products[index].images.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,int i){
                                    return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network("${openseaController.resp!.products[index].images[i]}"),
                                        );
                                  }),
                            )
                          ],
                        ),
                      );
                    }
                    ),
              )
        )
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}