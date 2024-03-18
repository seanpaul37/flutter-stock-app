import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:stock_app/core/RouterGenerator.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  dynamic payload;
  bool loading = false;
  List<dynamic> productdaData = [];
  @override
  void initState() {
    super.initState();
    // getAllProduct();
  }

  // getAllProduct() async {
  //   var url = Uri.parse("${ApiProvider.baseUrl}products");

  //   final res =
  //       await http.get(url, headers: {"Content-Type": "application/json"});
  //   var jsonResponse = jsonDecode(res.body);

  //   payload = jsonResponse["success"];
  //   try {
  //     if (res.statusCode == 200) {
  //       print(SecurityScreen.isLoaded.value);
  //       print("got successfully all Product");
  //       print("etape 1 : $payload");
  //       print("etape 4 : ${jsonResponse["success"][0]}");
  //     } else {
  //       print("Impossible d'accéder à la reponse du serveur");
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bienvenue",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20),
        ),
      ),
      body: Container(
        color: Color.fromARGB(153, 34, 17, 164),
        alignment: Alignment.center,
        width: size.width,
        child: Container(
          width: size.width / 2,
          height: size.height / 1.5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withAlpha(50),
                    spreadRadius: 2,
                    blurRadius: 0.2,
                    offset: const Offset(0, 3)),
              ]),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Plus qu'une seule étape",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    decorationStyle: TextDecorationStyle.solid),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Passons à la gestion",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.of(context).pushNamed(
                      RouterGenerator.homeRoute,
                      // arguments: payload
                    );
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Continuer",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cliquez ici",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  Icon(CupertinoIcons.arrow_up)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: "Veuillez appuyez sur ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: "Continuer ",
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(text: "Pour accéder au logiciel"),
                    ]),
              ),
              const Spacer(),
              const Text(
                "©Copyright 2024",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
