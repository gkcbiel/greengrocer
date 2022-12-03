import 'dart:ui';

import 'package:app_greengrocer/src/config/custom_colors.dart';
import 'package:app_greengrocer/src/models/cart_item_model.dart';
import 'package:app_greengrocer/src/pages/commom_widgtes/quantity_widget.dart';
import 'package:app_greengrocer/src/services/utils_services.dart';
import 'package:flutter/material.dart';

class CartTile extends StatefulWidget {
  final CartItemModel carItem;
  final Function(int) updateQuantity;

  const CartTile({
    Key? key,
    required this.carItem,
    required this.updateQuantity,
  }) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        //imagem
        leading: Image.asset(
          widget.carItem.item.imgUrl,
          height: 60,
          width: 60,
        ),

        //titulo
        title: Text(
          widget.carItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        //total
        subtitle: Text(
          utilsServices.priceToCurrency(
            widget.carItem.totalPrice(),
          ),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        //botão de quantidade
        trailing: QuantityWidget(
          suffixText: widget.carItem.item.unit,
          value: widget.carItem.quantity,              
          result: widget.updateQuantity,
          isRemovable: true,
        ),
      ),
    );
  }
}
