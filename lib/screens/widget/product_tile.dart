// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/custom_text.dart';

class ProductTile extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String productId;
  final String productQunatity;
  final VoidCallback onTap;
  final productBgColor;
  final String productImg;

  const ProductTile({
    Key? key,
    this.productBgColor,
    required this.productName,
    required this.productPrice,
    required this.productId,
    required this.productQunatity,
    required this.onTap,
    required this.productImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: productBgColor[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          //Price
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: productBgColor[100],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: CustomText(
                    text: "\$$productPrice",
                    fontsize: 16,
                    colors: productBgColor[800],
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          //Image
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Image.asset(
              productImg,
              scale: 4.0,
            ),
          ),
          //Flavour
          CustomText(
              text: productName,
              fontsize: 16,
              colors: Colors.black,
              fontWeight: FontWeight.w600),
          //Name
          const SizedBox(height: 3.5),
          CustomText(
            text: "Fruit's",
            fontsize: 12,
            colors: black.withOpacity(0.4),
            fontWeight: FontWeight.w600,
          ),
          //Buttons
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Id of Product : ",
                    fontsize: 13,
                    colors: black.withOpacity(0.4),
                    fontWeight: FontWeight.w600),
                CustomText(
                    text: productId,
                    fontsize: 11,
                    colors: black,
                    fontWeight: FontWeight.w600),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Available Quantity :",
                    fontsize: 13,
                    colors: black.withOpacity(0.4),
                    fontWeight: FontWeight.w600),
                CustomText(
                    text: productQunatity,
                    fontsize: 11,
                    colors: black,
                    fontWeight: FontWeight.w600),
              ],
            ),
          ),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: InkWell(
                onTap: onTap,
                child: Container(
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                    color: productBgColor[900],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: CustomText(
                        text: "Add More Quantity",
                        colors: white,
                        fontsize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
