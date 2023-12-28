import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasar_petani/app/global_widgets/empty_state.dart';
import 'package:pasar_petani/app/global_widgets/item_card.dart';
import 'package:pasar_petani/app/models/barang.dart';
import 'package:pasar_petani/app/models/koperasi.dart';
import 'package:pasar_petani/app/services/authentication.dart';
import 'package:pasar_petani/app/services/permintaan.dart';
import 'package:pasar_petani/config/theme/colors.dart';

class HomeController extends GetxController {
  static const primaryColor = Color(0xff62C172);
  static const bottomNavbarColor = Color(0xffAAAAAA);
  static const accentColor = Color(0xffF4FBF4);
  static const primaryShade1 = Color(0xffD1F3D1);

  RxInt currentIndex = 0.obs;

  late Future<void> itemInit;
  late Future<void> koperasiInit;
  Future<Koperasi> koperasi = Authentication().getProfile();
  List<Barang> _listBarang = [];
  Map<String, List<Barang>> statusBarang = {
    'baru': [],
    'proses': [],
    'selesai': [],
  };

  @override
  void onInit() {
    super.onInit();
    itemInit = refreshListBarang();
  }

  void currentIndexChange(int index) {
    refreshListBarang();
    currentIndex.value = index;
  }

  resetStatus() {
    statusBarang = {
      'baru': [],
      'proses': [],
      'selesai': [],
    };
  }

  Future<void> refreshListBarang() async {
    try {
      final listBarang = await Permintaan().getAll();
      _listBarang = listBarang;
      resetStatus();

      for (var item in _listBarang) {
        if (item.status.isEmpty) {
          statusBarang['baru']?.add(item);
        } else {
          switch (item.status.last.status.toLowerCase()) {
            case 'diproses':
              statusBarang['proses']?.add(item);
              break;
            case 'ditolak':
              statusBarang['selesai']?.add(item);
              break;
            case 'diterima':
              statusBarang['selesai']?.add(item);
              break;
            default:
              statusBarang[item.status.last.status.toLowerCase()]?.add(item);
              break;
          }
        }
      }
      if (kDebugMode) {
        print('refreshed');
      }
      update();
    } catch (e) {
      Get.snackbar('Gagal', e.toString());
      Get.toNamed('/login');
    }
  }

  Widget buildListTab(List<Barang> items, context) {
    return RefreshIndicator(
      color: CustomColors.primaryColor,
      onRefresh: refreshListBarang,
      child: items.isEmpty
          ? SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: const EmptyState()),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Barang item = items[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    child: ItemCard(
                      barang: item,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
