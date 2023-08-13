class Brand { 
 String brandName = "";
 String bottleImage ="";

  Brand({required this.brandName,required this.bottleImage});

  Brand.fromJson(Map<String, dynamic> json){
    brandName = json['brandName'];
    bottleImage = json['bottle_image'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data['brandName'] = brandName;
    data['bottle_image'] = bottleImage;

    return data;
  }

}