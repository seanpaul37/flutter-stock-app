// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyProduct extends StatelessWidget {
  const BuyProduct({
    Key? key,
    required this.products,
  }) : super(key: key);
  final dynamic products;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tableau d'achat des produits",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
          ],
        ),
        Container(
          width: size.width / 2,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.only(bottom: 5, left: 20, top: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withAlpha(50),
                    spreadRadius: 2,
                    blurRadius: 0.2,
                    offset: const Offset(0, 3)),
              ]),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(CupertinoIcons.bag_fill_badge_plus, color: Colors.red),
                  Text(
                    "Liste d'article(s) vendu(s)",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Icon(CupertinoIcons.bag_fill_badge_plus, color: Colors.red),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.only(bottom: 5, left: 20, top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(50),
                          spreadRadius: 2,
                          blurRadius: 0.2,
                          offset: const Offset(0, 3)),
                    ]),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nom d'article",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Nombre d'article",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: size.height * 0.3,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.only(bottom: 5, left: 20, top: 20),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    ...List.generate(
                        products.length,
                        (index) => Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${products[index]["name"]} : ",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      "${products[index]["buy"]}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider()
                              ],
                            )),
                  ],
                )),
              ),
              RichText(
                text: TextSpan(
                    text: "Nombre total d'articles vendus: ",
                    style:const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                    children: [
                      TextSpan(
                          text:
                              "${(products as List).toList().map((e) => e["buy"]).toList().fold<double>(0, (previousValue, element) => previousValue + element).toInt()}")
                    ]),
              )
            ],
          ),
        )
      ],
    );
  }
}
