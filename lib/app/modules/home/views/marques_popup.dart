import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/images.dart';

class MarquesPopup extends StatefulWidget {
  const MarquesPopup({super.key});

  @override
  _MarquesPopupState createState() => _MarquesPopupState();
}

class _MarquesPopupState extends State<MarquesPopup> {
  int selectedIndex = 0;
  List<String> marques = [
    'SCTM',
    'Tradex',
    'Oilibya',
    'CAMGAZ',
    'TOTAL',
    'GREEN_OIL',
    'BOCOM',
    'AFRIGAZ',
    'SOS_GAZ',
  ];
  @override
  void initState() {
    super.initState();
    marques.sort(); // Tri de la liste marques
  }

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
            Image.asset(
              AppImages.bouteilleGaz,
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 16),
            const Text(
              'Marques disponibles',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 35),
            SizedBox(
              height: 160,
              child: ListWheelScrollView.useDelegate(
                itemExtent: 40,
                diameterRatio: 1.5,
                offAxisFraction: -0.05,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (BuildContext context, int index) {
                    final isSelected = selectedIndex == index;
                    final fontSize = isSelected ? 18.0 : 16.0;
                    final scale = isSelected ? 1.2 : 1.0;
                    return Center(
                      child: Container(
                        decoration: isSelected
                            ? BoxDecoration(
                                border: Border.all(
                                  color: Colors.orange,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              )
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Transform.scale(
                            scale: scale,
                            child: Text(
                              marques[index],
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: marques.length,
                ),
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // Logique de sélection
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  'Sélectionner',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
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
