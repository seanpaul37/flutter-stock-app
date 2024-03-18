// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stock_app/components/constants/constant.dart';
import 'package:stock_app/windows/menus/ArticleOperation.dart';
import 'package:stock_app/windows/security/SecurityScreen.dart';

import '../../components/widgets/DetailSide_Widget.dart';
import '../../components/widgets/Header.dart';
import '../../components/widgets/SettingSide.dart';
import '../../core/states_manager/blocs/list_product_bloc.dart';
import '../menus/AddProdcut.dart';
import '../menus/BuyProduct.dart';
import '../menus/FaqMenu.dart';
import '../menus/ProductMenu.dart';
import '../menus/ProductStatMenu.dart';
import '../menus/SettingMenuScreen.dart';
import '../menus/User_Product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.payloads,
  });
  final dynamic payloads;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  static ValueNotifier<bool> active = ValueNotifier(false);
}

class _HomeScreenState extends State<HomeScreen> {
  List<IconData> icons = [
    Icons.search,
    CupertinoIcons.memories,
    CupertinoIcons.cart,
    Icons.settings,
  ];
  List<dynamic> foundUser = [];
  void isVisible() {
    setState(() {
      MenuSide.visible.value = !MenuSide.visible.value;
    });
  }

  bool loading = false;
  dynamic productdaData = [];
  loadProductsElements() {
    BlocProvider.of<ProductBloc>(context).add(ProductLoadedEvent());
  }

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Home value = ${SettingSide.indexPage.value}");
      // print("Home mylist Value = ${widget.mylist}");
    }
    final size = MediaQuery.of(context).size;
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
        setState(() {
          loading = state is ProductLoading;
        });
        if (state is ProductLoaded) {
          productdaData = state.productList;
          foundUser = state.productList;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  textAlign: TextAlign.center,
                  "Mise à jour des articles avec succés"),
              backgroundColor: Colors.blue.shade600,
            ),
          );
        }
        if (state is ProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  textAlign: TextAlign.center, "Une erreur s'est produite"),
              backgroundColor: Colors.red.shade600,
            ),
          );
        }
        setState(() {});
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
              color: const Color.fromARGB(255, 241, 239, 239),
              height: size.height,
              width: size.width,
              child: ValueListenableBuilder(
                  valueListenable: SettingSide.indexPage,
                  builder: (context, child, value) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Header(size: size),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SettingSide(size: size, icons: icons),
                              DetailSide(size: size),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      height: size.height * 0.8,
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: IndexedStack(
                                        index: SettingSide.indexPage.value,
                                        children: [
                                          Visibility(
                                            visible: productdaData.isNotEmpty,
                                            replacement: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            child: MenuSide(
                                              callback: () {
                                                setState(() {
                                                  isVisible();
                                                  if (kDebugMode) {
                                                    print(
                                                        MenuSide.visible.value);
                                                  }
                                                });
                                              },
                                              productList: foundUser,
                                              onChanged: (value) {
                                                // foundUser =
                                                //     show.where((element) => show.contains(value)).toList();
                                                foundUser = (productdaData
                                                        as List)
                                                    .toList()
                                                    .where((element) =>
                                                        element["name"]
                                                            .toString()
                                                            .toUpperCase()
                                                            .contains(value
                                                                .toUpperCase()))
                                                    .toList();
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                SecurityScreen.isAdmin.value,
                                            replacement: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            child: ProductStat(
                                              productList: productdaData,
                                            ),
                                          ),
                                          BuyProduct(
                                            products: productdaData,
                                          ),
                                          // const ProductsDeletes(),
                                          ProductSetting(),
                                          const ProdcutFaq(),
                                          const ProductUserMenu(),
                                          const AddProduct(),
                                          ArticleOperation(
                                            names: productdaData,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Text(YTECH),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  })),
        ),
      ),
    );
  }
}
