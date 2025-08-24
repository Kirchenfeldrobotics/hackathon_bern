import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:mobile_application/provider/providers.dart";
import "package:mobile_application/theme.dart" ;
import "package:mobile_application/shared/styled_text.dart" ;
import "package:mobile_application/data_models/product.dart" ; 


class ProductCard extends ConsumerWidget {
  const ProductCard({
    required this.myProduct, 
    super.key
  });

  final Product myProduct ; 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0,),
      child:Card(
      color : AppColors.secondaryAccentColor, 
      shape : RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))), 
      
      child : Row(
        mainAxisAlignment : MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding : EdgeInsetsGeometry.all(12), 
            child: StyledHeading(myProduct.productName)
          ),
          IconButton(
            icon : Icon(Icons.delete_outline), 
            onPressed: () {
              ref.read(productNotifierProvider.notifier).removeProduct(myProduct) ; 
            },
          )
        ],
      )
      
      )
    ) ;

  }
} 