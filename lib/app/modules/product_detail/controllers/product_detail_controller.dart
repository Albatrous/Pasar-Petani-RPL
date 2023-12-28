import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasar_petani/app/global_widgets/large_button.dart';
import 'package:pasar_petani/app/models/barang.dart';
import 'package:pasar_petani/app/modules/home/controllers/home_controller.dart';
import 'package:pasar_petani/app/services/status.dart';

class ProductDetailController extends GetxController {
  Barang detailProduct = Get.arguments['barang'];
  late String status;
  var homeController = Get.put(HomeController());

  Widget buttonDetail(context) {
    update();
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    if (kDebugMode) {
      print('ProductDetailController: ${detailProduct.name}');
    }
    if (detailProduct.status.isNotEmpty) {
      status = detailProduct.status.last.status.toLowerCase();
    } else {
      status = 'baru';
    }
    switch (status) {
      case 'selesai':
        return LargeButton(text: 'Submit', onPressed: () {});

      case 'diterima':
        return LargeButton(text: 'Submit', onPressed: () {});

      case 'ditolak':
        return LargeButton(text: 'Submit', onPressed: () {});

      case 'diproses':
        return LargeButton(text: 'Bayar', onPressed: () {});

      default:
        return ButtonBar(
          mainAxisSize: MainAxisSize.min,
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                minimumSize:
                    Size(MediaQuery.of(context).size.width * 0.4, 44 * ffem),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: const BorderSide(color: Colors.red, width: 1),
              ),
              child: const Text('Tolak'),
            ),
            ElevatedButton(
              onPressed: () {
                // showModalBottomSheet(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return Container(
                //         padding: const EdgeInsets.all(8),
                //         height: 200,
                //         child: Column(
                //           children: [
                //             const Text('Pilih Tanggal'),
                //             ElevatedButton(
                //               onPressed: () {},
                //               child: const Text('Pilih'),
                //             )
                //           ],
                //         ),
                //       );
                //     });
                // Get.back(result: 1);
                Status().addStatus(detailProduct.id, StatusPermintaan.diproses);
                homeController.currentIndexChange(1);
                Get.toNamed('/home');
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width * 0.4, 44 * ffem)),
                  elevation: MaterialStateProperty.all<double>(0),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff62C172)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xffFFFFFF)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
              child: const Text('Diterima'),
            ),
          ],
        );
    }
  }
}
