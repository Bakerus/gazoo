import 'package:get/get.dart';
import '../../../data/provider/brand_provider.dart'; 
import '../../../data/models/brand.dart'; 

class BrandController extends GetxController {
  var brandList = <Brand>[].obs;
  var isLoading = true.obs;
  var selectedBrand = "".obs;

  Future<void> fetchBrands() async {
    isLoading.value = true;

    try {
      final List<Brand> brands = await BrandProvider().getAllBrands();
      brandList.assignAll(brands);

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      // Handle errors here
    }
  }
}

