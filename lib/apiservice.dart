
import 'dart:convert';

import 'package:get/get.dart';
// import 'package:get/get_connect/connect.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:untitled14/DB/Products.dart';
import 'package:http/http.dart' as http;

import 'DB/Resp.dart';

// class ApiService{
//   Future<List<Products>>fetchProduct() async {
//     final response=await http.get(Uri.parse("https://dummyjson.com/products"));
//     if (response.statusCode==200){
//       final resp=json.decode(response.body);
//       var  data=await Resp.fromJson(resp);
//       var plist=data.products;
//       return plist;
//     }
//     else{
//       throw Exception('Failed to load');
//     }
//   }
// }


// class ApiService extends GetConnect {
//   Future<List<Products>> fetchData() async {
//     final response=await http.get(Uri.parse("https://dummyjson.com/products"));
//     if (response.statusCode==200){
//       final resp=json.decode(response.body);
//       var  data=await Resp.fromJson(resp);
//       var plist=data.products;
//       return plist;
//     }
//     else{
//       throw Exception('Failed to load');
//     }
//     // return await get('https://api.example.com/data');
//   }
// }
//
// import 'package:get/get.dart';
// // import 'package:getx_tutorials/models/opensea_model.dart';
// import 'package:http/http.dart' as http;
//
// import 'data.dart';

class OpenseaController extends GetxController {
  var isLoading = false.obs;
  Resp? resp;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          'https://dummyjson.com/products')!);
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);

        resp = Resp.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data');
    } finally {
      isLoading(false);
    }
  }
}
