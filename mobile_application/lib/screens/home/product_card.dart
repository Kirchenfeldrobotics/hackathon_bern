import 'package:flutter/material.dart';
import "package:mobile_application/theme.dart" ;
import "package:mobile_application/shared/styled_text.dart" ;
import "package:mobile_application/data_models/product.dart" ; 


class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.myProduct, 
    super.key
  });

  final Product myProduct ; 

  @override
  Widget build(BuildContext context) {
    return Card(
      color : AppColors.secondaryAccentColor!, 
      shape : RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))), 
      child : Row(
        spacing : 14, 
        children : [
          Icon(
            Icons.apple_outlined,
            color : Colors.black,  
            size : 40
          ), 
          Column(
            crossAxisAlignment : CrossAxisAlignment.start, 
            children : [
              StyledTitle(myProduct.productName), 
              Row(
                spacing : 4, 
                crossAxisAlignment : CrossAxisAlignment.center, 
                children : [
                  Icon(
                    Icons.folder_outlined, 
                    color : Colors.black
                  ), 
                  StyledText("3"), 
                  Text("Ds wird no cleaner, vertru")
                ]
              )
            ]
          )
        ]
      )
    ) ;

  }
} 