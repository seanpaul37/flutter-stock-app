// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/components/widgets/SettingSide.dart';
import 'package:stock_app/core/states_manager/blocs/delete_product_bloc.dart';

import 'package:stock_app/windows/security/SecurityScreen.dart';

import '../../core/services/ApiProvider.dart';
import 'package:http/http.dart' as http;

import '../../core/states_manager/blocs/list_product_bloc.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({
    super.key,
    required this.visible,
    required this.size,
    required this.productTitle,
    required this.productList,
  });

  final ValueNotifier<bool> visible;
  final Size size;
  final List<String> productTitle;

  final dynamic productList;

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  dynamic statusCode;
  dynamic productList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  loadProductsElements() {
    BlocProvider.of<ProductBloc>(context).add(ProductLoadedEvent());
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<DeleteProductBloc, DeleteProductState>(
      listener: (context, state) {
        setState(() {
          loading = state is DeleteProductLoading;
        });
        if (state is DeleteProductLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  textAlign: TextAlign.center, "article supprimé avec succés"),
              backgroundColor: Colors.blue.shade600,
            ),
          );
          loadProductsElements();
        }
        if (state is DeleteProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  textAlign: TextAlign.center, "Erreur de suppression"),
              backgroundColor: Colors.red.shade600,
            ),
          );
        }
      },
      child: Visibility(
          visible: widget.visible.value,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(
                          widget.productTitle.length,
                          (index) => index == 0
                              ? Expanded(
                                  flex: 4,
                                  child: Text(
                                    widget.productTitle[index],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                )
                              : Expanded(
                                  flex: 2,
                                  child: Text(
                                    widget.productTitle[index],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                        )
                      ])),
              const SizedBox(height: 10),
              SizedBox(
                  height: size.height * 0.3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...List.generate(
                            widget.productList.length,
                            (index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Row(
                                            children: [
                                              Visibility(
                                                visible: SecurityScreen
                                                    .isAdmin.value,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (kDebugMode) {
                                                      print("test ::$index");
                                                      "and";
                                                    }
                                                    problemButton(context,
                                                        callback: () {
                                                      BlocProvider.of<
                                                                  DeleteProductBloc>(
                                                              context)
                                                          .add(DeleteProductLoadedEvent(
                                                              widget.productList[
                                                                      index]
                                                                  ["_id"]));
                                                      Navigator.of(context)
                                                          .pop();
                                                      // setState(() {
                                                      //   if (kDebugMode) {}
                                                      //   Navigator.of(context).pop();
                                                      // });
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.red,
                                                      // borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    child: const Icon(Icons.add,
                                                        color: Colors.white,
                                                        size: 15),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                widget.productList[index]
                                                    ["name"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // ...List.generate(
                                        //   payloads.length,
                                        //   (index) => Expanded(
                                        //     flex: 2,
                                        //     child: Text(
                                        //       "${payloads[index]}",
                                        //       style: const TextStyle(
                                        //           color: Colors.black,
                                        //           fontWeight: FontWeight.w500),
                                        //     ),
                                        //   ),
                                        // ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${widget.productList[index]["code"]}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${widget.productList[index]["quantity"]}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${widget.productList[index]["quantity"] - widget.productList[index]["buy"]}",
                                            style: TextStyle(
                                                color: (widget.productList[
                                                                    index]
                                                                ["quantity"] -
                                                            widget.productList[
                                                                index]["buy"]) <
                                                        10
                                                    ? Colors.red
                                                    : Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${widget.productList[index]["reserved"]}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${widget.productList[index]["buyPrice"]}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${widget.productList[index]["salePrice"]}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                )),
                      ],
                    ),
                  )),
              const Divider(color: Colors.black, thickness: 2, height: 2),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                const Text(
                  "Nombre total d'article : ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                Text(
                  "${widget.productList.length}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ]),
              const Divider(color: Colors.red, thickness: 5, height: 5),
              const SizedBox(height: 10),
              Visibility(
                  visible: SecurityScreen.isAdmin.value,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Cotation totale des articles : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          Text(
                            "${(widget.productList as List).toList().map((e) => e["buyPrice"]).toList().fold<double>(0, (previousValue, element) => previousValue! + element)} FCFA",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Cotation totale de vente prevue : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          Text(
                            "${(widget.productList as List).toList().map((e) => e["salePrice"]).toList().fold<double>(0, (previousValue, element) => previousValue! + element)} FCFA",
                            style: TextStyle(
                                color: Colors.red.shade600,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ))
            ]),
          )),
    );
  }

  Future<dynamic> problemButton(BuildContext context,
      {required VoidCallback callback}) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
              return AlertDialog(
                title: Container(
                    padding: const EdgeInsets.all(19),
                    color: const Color(0xFF323E50),
                    child: const Text(
                      "Suppression de la liste ?",
                      style: TextStyle(color: Colors.white),
                    )),
                content: SizedBox(
                  height: 80,
                  width: 100,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: callback,
                        // setState(() {
                        //   if (kDebugMode) {}
                        //   Navigator.of(context).pop();
                        // });
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: const Center(
                            child: Text(
                              "Supprimer",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: const Center(
                            child: Text(
                              "Annuler",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
