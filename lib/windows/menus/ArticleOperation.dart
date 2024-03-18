// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/core/states_manager/blocs/update_product_bloc.dart';

import '../../components/widgets/ValidateWidget.dart';
import '../../core/states_manager/blocs/list_product_bloc.dart';
import '../home/HomeScreen.dart';

class ArticleOperation extends StatefulWidget {
  const ArticleOperation({
    Key? key,
    required this.names,
  }) : super(key: key);
  final List<dynamic> names;

  @override
  State<ArticleOperation> createState() => _ArticleOperationState();
}

class _ArticleOperationState extends State<ArticleOperation> {
  final TextEditingController buyController = TextEditingController();
  final TextEditingController reserveController = TextEditingController();
  bool loading = false;
  String buyId = "";
  String reserveId = "";
  int oldBuy = 0;
  int oldReserve = 0;
  @override
  void initState() {
    super.initState();
    loadProductsElements();
  }

  loadProductsElements() {
    BlocProvider.of<ProductBloc>(context).add(ProductLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(widget.names
        .where((element) => element["buy"] < element["quantity"])
        .toList());
    print("juste tester");
    var test = widget.names
        .where((element) => element["buy"] < element["quantity"])
        .toList();
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateProductBloc, UpdateProductState>(
            listener: (context, state) {
          setState(() {
            loading = state is UpdateProductLoading;
          });
          if (state is UpdateProductLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                    textAlign: TextAlign.center,
                    "Action effectuée avec succés"),
                backgroundColor: Colors.green.shade600,
              ),
            );
            buyController.clear();
            reserveController.clear();
            loadProductsElements();
          }

          if (state is UpdateProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                    textAlign: TextAlign.center,
                    "Erreur de la sortie. Vérifiez les données enregistrées"),
                backgroundColor: Colors.red.shade600,
              ),
            );
          }
        }),
      ],
      child: Container(
          width: size.width * 03,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Effectuer une sortie d'article",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: DropdownButtonFormField<String>(
                      hint: Text(buyId),
                      onSaved: (value) {
                        setState(() {
                          buyId == value!;
                          print(buyId);
                        });
                      },
                      items: [
                        ...List.generate(
                          test.length,
                          (index) => DropdownMenuItem(
                            value: test[index]["_id"],
                            child: Text("${test[index]["name"]}"),
                            onTap: () {
                              setState(() {
                                oldBuy = test[index]["buy"];
                                print(oldBuy);
                              });
                            },
                          ),
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          buyId = value!;
                        });
                      },
                      onTap: () {
                        setState(() {
                          buyId;
                          print("test");
                          print(buyId);
                        });
                      },
                    )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      height: size.height * 0.07,
                      child: TextFormField(
                        controller: buyController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: "Entrez  le nombre...",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    // Text("Disponible :$buyId"),
                    ValidateWidget(
                      callback: () {
                        dynamic payload = {
                          "buy": int.parse(buyController.text) + oldBuy
                        };
                        BlocProvider.of<UpdateProductBloc>(context).add(
                            UpdateProductEvent(id: buyId, payload: payload));
                        // buyController.clear();
                        setState(() {});
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const Text(
                  "OU",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Relever une réservation d'article",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: DropdownButtonFormField<String>(
                      hint: Text(reserveId),
                      onSaved: (value) {
                        setState(() {
                          reserveId = value!;
                        });
                      },
                      items: [
                        ...List.generate(
                          test.length,
                          (index) => DropdownMenuItem(
                            value: test[index]["_id"],
                            child: Text("${test[index]["name"]}"),
                            onTap: () {
                              oldReserve = test[index]["reserved"];
                              print(oldReserve);
                            },
                          ),
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          reserveId = value!;
                        });
                      },
                    )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      height: size.height * 0.07,
                      child: TextFormField(
                        controller: reserveController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: "Entrez  le nombre......",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    ValidateWidget(
                      callback: () {
                        dynamic payload = {
                          "reserved":
                              int.parse(reserveController.text) + oldReserve
                        };
                        BlocProvider.of<UpdateProductBloc>(context).add(
                            UpdateProductEvent(
                                id: reserveId, payload: payload));
                        // buyController.clear();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
