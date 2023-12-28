import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pasar_petani/config/theme/colors.dart';
import 'package:pasar_petani/config/theme/default_theme.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return GetBuilder<HomeController>(builder: (_) {
      return DefaultTabController(
        initialIndex: controller.currentIndex,
        length: 3,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(132 * fem),
              child: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: defaultTheme.primaryColor,
                  toolbarHeight: 88,
                  iconTheme: const IconThemeData(color: Colors.white),
                  title: Text('Permintaan',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          height: 1.2 * ffem / fem,
                          fontWeight: FontWeight.w700)),
                  bottom: PreferredSize(
                      preferredSize: const Size(375, 48),
                      child: Material(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Stack(
                              fit: StackFit.passthrough,
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffE1E1E1),
                                              width: 1))),
                                ),
                                TabBar(
                                  indicatorColor: CustomColors.primaryColor,
                                  unselectedLabelColor:
                                      CustomColors.bottomNavbarColor,
                                  labelColor: CustomColors.primaryColor,
                                  labelStyle: GoogleFonts.poppins(
                                      color: CustomColors.primaryColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                  indicator: const UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                          width: 1.0,
                                          color: CustomColors.primaryColor)),
                                  tabs: const [
                                    Tab(
                                        child: Text("Baru",
                                            textAlign: TextAlign.center)),
                                    Tab(
                                        child: Text("Proses",
                                            textAlign: TextAlign.center)),
                                    Tab(
                                        child: Text("Selesai",
                                            textAlign: TextAlign.center)),
                                  ],
                                ),
                              ]),
                        ),
                      ))),
            ),
            body: Container(
                color: CustomColors.accentColor,
                child: FutureBuilder(
                    future: controller.itemInit,
                    builder: (context, snapshot) {
                      // If connection state is waiting, show loading indicator
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const TabBarView(children: [
                          Center(child: CircularProgressIndicator()),
                          Center(child: CircularProgressIndicator()),
                          Center(child: CircularProgressIndicator()),
                        ]);
                      }

                      // If connection state is done and snapshot has error, show error message
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasError) {
                        final errorMessage =
                            snapshot.error?.toString() ?? 'Unknown error';
                        return TabBarView(children: [
                          Center(child: Text(errorMessage)),
                          Center(child: Text(errorMessage)),
                          Center(child: Text(errorMessage)),
                        ]);
                      }
                      return TabBarView(children: [
                        controller.buildListTab(
                            controller.statusBarang['baru']!, context),
                        controller.buildListTab(
                            controller.statusBarang['proses']!, context),
                        controller.buildListTab(
                            controller.statusBarang['selesai']!, context),
                      ]);
                    })),
            endDrawer: Drawer(
              child: FutureBuilder(
                future: controller.koperasi,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DrawerHeader(
                            padding: const EdgeInsets.all(18),
                            child: Center(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        NetworkImage(snapshot.data!.photoUrl!),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Text(
                                      snapshot.data!.name,
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data!.role!.capitalize!,
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TextButton.icon(
                            icon: SvgPicture.asset(
                              'assets/svg/logout.svg',
                              width: 24,
                              height: 24,
                              color: CustomColors.primaryColor,
                            ),
                            label: const Text('Logout Akun',
                                style: TextStyle(
                                    color: CustomColors.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                            onPressed: () {
                              Get.toNamed('/login');
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )),
      );
    });
  }
}
