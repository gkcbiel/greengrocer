import 'package:app_greengrocer/src/models/cart_item_model.dart';
import 'package:app_greengrocer/src/pages/cart/components/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:app_greengrocer/src/config/custom_colors.dart';
import 'package:app_greengrocer/src/services/utils_services.dart';
import 'package:app_greengrocer/src/config/app_data.dart' as appData;

import '../commom_widgtes/payment_dialog.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeItemFromCart(CartItemModel carItem) {
    setState(() {
      appData.cartItems.remove(carItem);
      utilsServices.showToast(message: '${carItem.item.itemName} removido(a) do carrinho');
    });
  }

  double cartTotalPrice() {
    double total = 0;
    for (var item in appData.cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: appData.cartItems.length,
              itemBuilder: (_, index) {
                final cartItem = appData.cartItems[index];
                return CartTile(
                  carItem: appData.cartItems[index],
                  updateQuantity: (qtd) {
                    if (qtd == 0) {
                      removeItemFromCart(appData.cartItems[index]);
                    } else {
                      setState(() => cartItem.quantity = qtd);
                    }
                  },
                );
              },
            ),
          ),

          //Conclusão do pedido
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total geral',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  utilsServices.priceToCurrency(cartTotalPrice()),
                  style: TextStyle(
                      fontSize: 23,
                      color: CustomColors.customSwatchColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();

                      if (result ?? false) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return PaymentDialog(
                              order: appData.orders.first,
                            );
                          },
                        );
                      }else{
                        utilsServices.showToast(message: 'Pedido não confirmado',);
                      }
                    },
                    child: const Text(
                      'Concluir pedido',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
