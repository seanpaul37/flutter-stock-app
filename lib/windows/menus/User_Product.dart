// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/core/states_manager/blocs/add_gest_bloc.dart';

class ProductUserMenu extends StatefulWidget {
  const ProductUserMenu({
    super.key,
  });

  @override
  State<ProductUserMenu> createState() => _ProductUserMenuState();
}

class _ProductUserMenuState extends State<ProductUserMenu> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    bool loading = false;
    final size = MediaQuery.of(context).size;

    return BlocListener<AddGestBloc, AddGestState>(
      listener: (context, state) {
        setState(() {
          loading = state is AddGestLoading;
        });
        if (state is AddGestLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  textAlign: TextAlign.center,
                  "Gestionnaire ajouté avec succès"),
              backgroundColor: Colors.blue.shade600,
            ),
          );
        }
        if (state is AddGestError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  textAlign: TextAlign.center, "Une erreur est survenue"),
              backgroundColor: Colors.blue.shade600,
            ),
          );
        }
      },
      child: Scaffold(
          body: Column(children: [
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Gestion des utilisateurs",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 20))
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ...List.generate(
              1,
              (index) => Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: const EdgeInsets.only(right: 10, top: 30),
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withAlpha(50),
                            spreadRadius: 2,
                            blurRadius: 0.2,
                            offset: const Offset(0, 3))
                      ]),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Nombre d'utilisateur",
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        Text("test",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue)),
                      ])))
        ]),
        const SizedBox(height: 30),
        const Text("Ajouter un/des utilisateur(s)",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            child: Column(children: [
              const Text("Nom d'utlisateur",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 16)),
              SizedBox(
                  width: size.width * 0.45,
                  height: size.height * 0.07,
                  child: TextFormField(
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "Ajouter un nom d'utilisateur",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))))),
              const SizedBox(height: 20),
              const Text("Mot de Passe",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 16)),
              SizedBox(
                  width: size.width * 0.45,
                  height: size.height * 0.07,
                  child: TextFormField(
                      controller: passController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "Ajouter un mot de passe",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))))),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  var payload = {
                    "name": nameController.text,
                    "password": passController.text,
                    "admin": false
                  };
                  setState(() {
                    BlocProvider.of<AddGestBloc>(context)
                        .add(AddGestEvent(payload));
                  });
                },
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    width: size.width * 0.45,
                    height: size.height * 0.07,
                    child: const Text("Ajouter le profil",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16))),
              )
            ]))
      ])),
    );
  }
}
