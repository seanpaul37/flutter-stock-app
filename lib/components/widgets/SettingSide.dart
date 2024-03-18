// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/core/services/Navigation_Service.dart';
import 'package:stock_app/windows/security/SecurityScreen.dart';

import '../../core/states_manager/blocs/list_product_bloc.dart';

class SettingSide extends StatefulWidget {
  const SettingSide({
    super.key,
    required this.size,
    required this.icons,
  });

  final Size size;
  final List<IconData> icons;
  @override
  State<SettingSide> createState() => _SettingSideState();
  static ValueNotifier<int> indexPage = ValueNotifier(0);
}

class _SettingSideState extends State<SettingSide> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProductsElements();
  }

  loadProductsElements() {
    BlocProvider.of<ProductBloc>(context).add(ProductLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("valueIndex == ${SettingSide.indexPage.value}");
    }
    return Container(
      height: widget.size.height * 0.9,
      // padding: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          color: const Color(0xFF323E50),
          border: Border(right: BorderSide(color: Colors.white.withAlpha(20)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            widget.icons.length,
            (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ValueListenableBuilder(
                    valueListenable: SettingSide.indexPage,
                    builder: (context, value, page) {
                      return Container(
                        decoration: BoxDecoration(
                            color: SettingSide.indexPage.value == index
                                ? Colors.red
                                : const Color(0xFF323E50),
                            shape: BoxShape.circle),
                        child: IconButton(
                          hoverColor: Colors.redAccent.withAlpha(50),
                          highlightColor:
                              const Color.fromARGB(255, 170, 97, 97),
                          onPressed: () {
                            setState(() {
                              // indexPage.value = widget.valueIndex;
                              SettingSide.indexPage.value = index;
                              if (SettingSide.indexPage.value == 0) {
                                loadProductsElements();
                              }
                            });
                          },
                          icon: Icon(
                            widget.icons[index],
                            color: Colors.white,
                          ),
                        ),
                      );
                    })),
          ),
          const Spacer(),
          Visibility(
            visible: !SecurityScreen.isAdmin.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    // indexPage.value = widget.valueIndex;
                    SettingSide.indexPage.value = 4;
                    if (kDebugMode) {
                      print("Mon index est ::: ${SettingSide.indexPage.value}");
                    }
                  });
                },
                icon: const Icon(
                  CupertinoIcons.question_circle_fill,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Visibility(
            visible: SecurityScreen.isAdmin.value,
            replacement: GestureDetector(
              onTap: () {
                setState(() {
                  // indexPage.value = widget.valueIndex;
                  NavigationService.goBack();
                });
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.red,
                child: const Icon(
                  Icons.logout_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  // indexPage.value = widget.valueIndex;
                  SettingSide.indexPage.value = 5;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.red,
                child: const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
