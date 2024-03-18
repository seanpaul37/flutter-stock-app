// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../core/states_manager/blocs/add_product_blocs.dart';
import '../home/HomeScreen.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    super.key,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool loading = false;
  List<String> types = [
    "nom",
    "Quantité",
    "Reservé",
    "Prix d'achat",
    "Prix de vente",
  ];

  final TextEditingController nameController = TextEditingController();

  final TextEditingController codeController = TextEditingController();

  final TextEditingController quantityController = TextEditingController();

  final TextEditingController reserveController = TextEditingController();

  final TextEditingController buyPriceController = TextEditingController();

  final TextEditingController salePriceController = TextEditingController();

  // void active() {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(
  //           builder: (BuildContext context, StateSetter state) {
  //             return AlertDialog(
  //               title: const Center(child: Text("Article ajouté")),
  //               content: GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     HomeScreen.active.value = false;
  //                     if (kDebugMode) {
  //                       print(HomeScreen.active.value);
  //                     }
  //                     Navigator.of(context).pop();
  //                   });
  //                 },
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                       color: Colors.blue,
  //                       borderRadius: BorderRadius.circular(10)),
  //                   height: 50,
  //                   width: 100,
  //                   child: const Center(
  //                     child: Text(
  //                       "Retour",
  //                       style: TextStyle(
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 16),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       });
  //   setState(() {
  //     HomeScreen.active.value = true;
  //     if (kDebugMode) {
  //       print(HomeScreen.active.value);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> productController = [
      nameController,
      quantityController,
      reserveController,
      buyPriceController,
      salePriceController,
      codeController,
    ];
    final size = MediaQuery.of(context).size;
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        // TODO: implement listener
        setState(() {
          loading = state is AddProductLoading;
        });
        if (state is AddProductLoaded) {
          print("Envoyé avec succès");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  textAlign: TextAlign.center, "Article ajouté avec succès"),
              backgroundColor: Colors.blue.shade600,
            ),
          );
          nameController.clear();
          quantityController.clear();
          reserveController.clear();
          buyPriceController.clear();
          salePriceController.clear();
          codeController.clear();
        }
        if (state is AddProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  textAlign: TextAlign.center,
                  "Une erreur s'est produite. Vérifier vos infos rentrées"),
              backgroundColor: Colors.blue.shade600,
            ),
          );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ajout de produit(s)",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
            ...List.generate(
                types.length,
                (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            types[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.45,
                            height: size.height * 0.07,
                            child: TextFormField(
                              controller: productController[index],
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText:
                                      "Entrez ${types[index]} du produit...",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ],
                      ),
                    )),
            GestureDetector(
              onTap: () {
                dynamic payload = {
                  "name": nameController.text,
                  "code":
                      "${nameController.text.toUpperCase().substring(0, 4)}-${DateFormat('Md').format(DateTime.now())}",
                  "quantity": quantityController.text,
                  "reserved": reserveController.text,
                  "buyPrice": buyPriceController.text,
                  "salePrice": salePriceController.text,
                  "date": DateFormat('EEEE').format(DateTime.now()),
                  "buy": "0",
                };
                // addProduct({
                //   "name": nameController.text,
                //   "code":
                //       "${nameController.text.toUpperCase().substring(0, 4)}-${DateFormat('Md').format(DateTime.now())}",
                //   "quantity": quantityController.text,
                //   "reserved": reserveController.text,
                //   "buyPrice": buyPriceController.text,
                //   "salePrice": salePriceController.text,
                //   "date": "${DateFormat('EEEE').format(DateTime.now())}"
                // });
                BlocProvider.of<AddProductBloc>(context)
                    .add(AddProductEvent(payload));
                setState(() {
                  // active();
                });
              },
              child: Container(
                // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                width: size.width * 0.45,
                height: size.height * 0.06,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child:
                      // Text(
                      //   "Enregistrer",
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: 20),
                      // ),
                      Text(
                    "Enregistrer",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
