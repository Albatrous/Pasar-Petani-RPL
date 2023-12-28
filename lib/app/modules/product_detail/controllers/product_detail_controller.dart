import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasar_petani/app/global_widgets/large_button.dart';
import 'package:pasar_petani/app/models/barang.dart';
import 'package:pasar_petani/app/modules/home/controllers/home_controller.dart';
import 'package:pasar_petani/app/services/status.dart';
import 'package:pasar_petani/config/theme/colors.dart';

class ProductDetailController extends GetxController {
  late Barang detailProduct;
  late String status;
  var homeController = Get.put(HomeController());
  final RxString _selectedMethod = 'bankXYZ'.obs;

  @override
  void onInit() {
    super.onInit();
    detailProduct = Get.arguments['detailProduct'];
  }

  Widget _buildRadioListTile({required String title, required String value}) {
    return RadioListTile(
        title: Text(title,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, height: 1.2)),
        value: value,
        groupValue: _selectedMethod.value,
        activeColor: CustomColors.primaryColor,
        controlAffinity: ListTileControlAffinity.trailing,
        onChanged: (value) => {_selectedMethod.value = value as String});
  }

  Widget _buildPaymentModal(context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        height: 238,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pilih Metode Pembayaran',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w900, height: 1.2)),
            Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRadioListTile(title: 'Bank XYZ', value: 'bankXYZ'),
                    _buildRadioListTile(title: 'E-Wallet A', value: 'eWalletA'),
                    _buildRadioListTile(title: 'E-Wallet B', value: 'eWalletB'),
                  ],
                )),
            Expanded(
                child: LargeButton(
                    text: 'Ok',
                    onPressed: () {
                      Status().payment(11, detailProduct.harga.toString());
                      Status().addStatus(
                          detailProduct.id, StatusPermintaan.diterima);
                      Navigator.pop(context);
                      homeController.currentIndexChange(2);
                      Get.back();
                    }))
          ],
        ),
      ),
    );
  }

  Widget buttonDetail(context) {
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
      case 'diproses':
        return LargeButton(
            text: 'Bayar',
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildPaymentModal(context);
                  });
            });

      case 'baru':
        return ButtonBar(
          mainAxisSize: MainAxisSize.min,
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () {
                Status().addStatus(detailProduct.id, StatusPermintaan.ditolak);
                homeController.currentIndexChange(1);
                Get.back();
              },
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
                Status().addStatus(detailProduct.id, StatusPermintaan.diproses);
                homeController.currentIndexChange(1);
                Get.back();
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

      default:
        return LargeButton(text: 'Submit', onPressed: () {});
    }
  }
}
