// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'product_list_widget.dart';

class OngletWidget extends StatelessWidget {
  const OngletWidget({
    Key? key,
    required this.callback,
    required this.size,
    required this.visible,
    required this.productTitle,
    required this.productList,
    this.onChanged,
  }) : super(key: key);

  final VoidCallback callback;
  final Size size;
  final ValueNotifier<bool> visible;
  final List<String> productTitle;
  final dynamic productList;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: callback,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Text(
                  "Afficher / Masquer",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Text(
                  "Trier par",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800),
                ))
          ],
        ),
        const SizedBox(height: 10),
        SearchWidget(
          size: size,
          onChanged: onChanged,
          productList: productList,
        ),
        const SizedBox(height: 10),
        ProductListWidget(
            visible: visible,
            size: size,
            productTitle: productTitle,
            productList: productList),
      ],
    );
  }
}

class SearchWidget extends StatelessWidget {
  SearchWidget({
    Key? key,
    this.onChanged,
    required this.size,
    required this.productList,
  }) : super(key: key);
  final ValueChanged<String>? onChanged;
  final Size size;
  final dynamic productList;

  dynamic onSearch = [];
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        width: size.width * 0.45,
        height: size.height * 0.07,
        child: TextFormField(
          onChanged: onChanged,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintText: " Rechercher par: Titre du produit, code ou prix",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10)),
        child: const Text(
          "Rechercher",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      )
    ]);
  }
}
