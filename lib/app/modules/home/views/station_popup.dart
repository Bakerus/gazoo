import 'package:flutter/material.dart';
import 'package:gazoo/app/data/models/vendors.dart';

import 'package:gazoo/app/core/design/colors.dart';

class StationPopup extends StatefulWidget {
  final List<Vendors> vendorsLists;

  StationPopup({super.key, required this.vendorsLists});

  @override
  _StationPopupState createState() => _StationPopupState();
}

class _StationPopupState extends State<StationPopup> {
  List<String> villes = ['Sangmelima', 'Meyomessala', 'Zoetele', 'Avebe Esse'];
  String selectedVille = 'Sangmelima'; // ou toute autre valeur par défaut

  List<bool> isButtonPressed = [false, false, false, false];
  List<Vendors> vendorsLists = <Vendors>[];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.menu,
              size: 48,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            const Text(
              'Points de ventes',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tradex',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 200,
              height: 30,
              child: DropdownButtonFormField<String>(
                value: selectedVille,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedVille = newValue!;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.orange,
                ),
                isDense: true,
                isExpanded: true,
                items: villes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(child: Text(value)),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: ListView.separated(
                itemCount: widget.vendorsLists.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 16),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        for (int i = 0; i < isButtonPressed.length; i++) {
                          if (i == index) {
                            isButtonPressed[i] = !isButtonPressed[i];
                          } else {
                            isButtonPressed[i] = false;
                          }
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: isButtonPressed[index]
                              ? Colors.orange
                              : const Color.fromARGB(255, 238, 236, 236),
                          width: 2, // Largeur de la bordure
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.store, color: AppColors.brown),
                              const SizedBox(height: 8),
                              Container(
                                width: 80,
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  widget.vendorsLists[index].name,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                  ),
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.location_pin,
                                  color: AppColors.brown),
                              const SizedBox(height: 8),
                              Text(
                                widget.vendorsLists[index].address,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.phone_android_outlined,
                                  color: AppColors.brown),
                              const SizedBox(height: 8),
                              Text(
                                widget.vendorsLists[index].phone,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromARGB(255, 241, 241, 241),
                  width: 2, // Largeur de la bordure
                ),
              ),
            ),
            const SizedBox(height: 23),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Center(
                child: Text(
                  'Sélectionner',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
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
