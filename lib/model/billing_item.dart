class BillingItem {
  final String itemName;
  final double itemPrice;
  final double itemGrossWeight;
  final double itemNetWeight;
  final int itemPcs;
  final String itemImage;
  final String itemPurity;
  final double ratePerGram;
  final double otherCharges;
  final double labourCharges;
  final double gstCharges;
  final double grossAmount;

  BillingItem({
    required this.itemName,
    required this.itemPrice,
    required this.itemGrossWeight,
    required this.itemNetWeight,
    required this.itemPcs,
    required this.itemImage,
    required this.itemPurity,
    required this.ratePerGram,
    required this.otherCharges,
    required this.labourCharges,
    required this.gstCharges,
    required this.grossAmount,
  });
}


// Map<String, dynamic> toMap() {
//     return {
//       'itemName': name,
//       'itemPurity': purity,
//       'itemPcs': pieces,
//       'itemGrossWeight': grossWeight,
//       'itemNetWeight': netWeight,
//       'ratePerGram': ratePerGram,
//       'otherCharges': otherCharges,
//       'labourCharges' : labourCharges,
//       'itemPrice': price,
//     };
//   }
// }
