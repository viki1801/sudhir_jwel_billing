import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sudhir_jwel_billing/Custom%20Widgets/stepper_textfield.dart';

class ItemForm extends StatefulWidget {
  final TextEditingController itemNameController;
  final TextEditingController itemPriceController;
  final TextEditingController itemGrossWeightController;
  final TextEditingController itemNetWeightController;
  final TextEditingController itemPurityController;
  final TextEditingController itemPcsController;
  final TextEditingController ratePerGramController;
  final TextEditingController otherChargesController;
  final Function(double) onItemPriceChanged;
  final Function(String) onImagePathChanged;

  const ItemForm({
    super.key,
    required this.itemNameController,
    required this.itemPriceController,
    required this.itemPurityController,
    required this.onItemPriceChanged,
    required this.itemGrossWeightController,
    required this.itemNetWeightController,
    required this.itemPcsController,
    required this.ratePerGramController,
    required this.otherChargesController,
    required this.onImagePathChanged,
  });

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  String selectedImagePath = '';
  double itemPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // item image
                selectedImagePath.isEmpty
                    ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                  height: 180,
                  width: 300,
                  child: const Icon(Icons.add_a_photo_outlined, size: 66),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(
                    File(selectedImagePath),
                    height: 180,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black87),
                  ),
                  onPressed: () async {
                    await selectImage();
                  },
                  child: const Text(
                    "Select",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Item name
        StepperTextField(
          icon: Icons.badge,
          controller: widget.itemNameController,
          labeltext: "Item name",
          keyboardType: TextInputType.text,
        ),
        // Item purity
        StepperTextField(
          icon: Icons.water_drop,
          controller: widget.itemPurityController,
          labeltext: "Item purity",
          keyboardType: TextInputType.text,
        ),
        // Item Pieces
        StepperTextField(
          icon: Icons.line_weight,
          controller: widget.itemPcsController,
          labeltext: "How many pieces",
          keyboardType: TextInputType.number,
        ),
        // Item Gross weight
        StepperTextField(
          icon: Icons.line_weight,
          controller: widget.itemGrossWeightController,
          labeltext: "Gross Wt",
          keyboardType: TextInputType.number,
        ),
        // Item Net weight
        StepperTextField(
          icon: Icons.line_weight,
          controller: widget.itemNetWeightController,
          labeltext: "Net Wt",
          keyboardType: TextInputType.number,
        ),
        // Rate Per gram
        StepperTextField(
          icon: Icons.line_weight,
          controller: widget.ratePerGramController,
          labeltext: "Rate [Per Gm]",
          keyboardType: TextInputType.number,
        ),
        // Other Charges
        StepperTextField(
          icon: Icons.line_weight,
          controller: widget.otherChargesController,
          labeltext: "Other Charges",
          keyboardType: TextInputType.number,
        ),
        // Item Price
        Row(
          children: [
            const Icon(
              Icons.currency_rupee,
              color: Colors.black54,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                controller: widget.itemPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Item Price",
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    letterSpacing: 1,
                  ),
                ),
                onChanged: (String value) {
                  try {
                    itemPrice = double.parse(value);
                    widget.onItemPriceChanged(itemPrice);
                  } catch (exception) {
                    itemPrice = 0.0;
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ],
    );
  }

  Future<void> selectImage() async {
    final path = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Text(
                    'Select Image From',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context, await selectImageFromGallery());
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(Icons.image, size: 40),
                              Text('Gallery'),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context, await selectImageFromCamera());
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(Icons.camera_alt, size: 40),
                              Text('Camera'),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, '');
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(Icons.clear, size: 40),
                              Text('Cancel'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (path != null && path.isNotEmpty) {
      setState(() {
        selectedImagePath = path;
      });
      widget.onImagePathChanged(selectedImagePath); // Notify parent
    } else if (path == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No Image Selected...!")),
      );
    }
  }

  Future<String> selectImageFromGallery() async {
    final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  Future<String> selectImageFromCamera() async {
    final XFile? file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}
