import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/images.dart';
import 'package:gazoo/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import '../controllers/brand_controller.dart';

class MarquesPopup extends StatefulWidget {
  const MarquesPopup({super.key});

  @override
  _MarquesPopupState createState() => _MarquesPopupState();
}

class _MarquesPopupState extends State<MarquesPopup> {
  int selectedIndex = 0;
   late String selectedBrand;

  

  @override
  void initState() {
    super.initState();
    final brandController = Get.put(BrandController());
    brandController.fetchBrands(); // Appel de la méthode pour récupérer les données



    // Initialisation de la variable selectedBrand avec la première marque
    selectedBrand = brandController.brandList.isNotEmpty
        ? brandController.brandList[0].brandName
        : '';
  }
   
  

   @override
  Widget build(BuildContext context) {
    final brandController = Get.find<BrandController>();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Obx(() {
        if (brandController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Container(
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
                      final marqueName = brandController.brandList[index].brandName;
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
                                marqueName,
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
                    childCount: brandController.brandList.length,
                  ),
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      selectedIndex = index;
                      selectedBrand = brandController.brandList[index].brandName; // Mise à jour de la marque sélectionnée
                    });
                  },
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                 // Logique de sélection
                    final controller = Get.put(HomeController());
                    controller.selectedBrand.value = selectedBrand; // Met à jour la marque sélectionnée dans HomeController
                    Get.back(); // Ferme la popup après la sélection 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
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
        );
      }),
    );
  }
}
