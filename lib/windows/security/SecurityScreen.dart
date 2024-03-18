// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/core/RouterGenerator.dart';
import 'package:stock_app/core/services/ApiProvider.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  static ValueNotifier<bool> isAdmin = ValueNotifier(false);
  static ValueNotifier<bool> isLoaded = ValueNotifier(false);
  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  dynamic productList;
  Future<void> loginUser() async {
    try {
      if (nameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        ApiProvider.loginUser({
          "name": nameController.text,
          "password": passwordController.text,
        });
      } else {
        _isNotValidate = true;
        //  Navigator.of(context).pushNamed(RouterGenerator.homeRoute);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Connexion  Admin / Gestionnaire",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20),
          ),
        ),
        body: Container(
          color: Colors.white60,
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
                  "Nom d'utilisateur",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
                SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.07,
                  child: TextFormField(
                    controller: nameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "Entrez votre nom d'utilisateur",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Mot de passe",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
                SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.07,
                  child: TextFormField(
                    controller: passwordController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        errorText: _isNotValidate ? "Vérifier vos infos" : null,
                        hintText: "Entrez votre Mot de Passe",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      loginUser();
                      print(nameController.text);
                      print(passwordController.text);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "Connexion",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                      text: "Nouvelle connexion ",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          text: "ou ",
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(text: "Mot de passe oublié ?"),
                      ]),
                ),
                GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      print("Account problem");
                    }
                  },
                  child: const Text(
                    "Cliquez ici",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                const Text(
                  "©Copyright 2024",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
