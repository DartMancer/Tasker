import 'package:flutter/material.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/utils/utils.dart';

class DescriptionModal extends StatelessWidget {
  const DescriptionModal({
    super.key,
    required this.descriptionController,
    required this.saveDescription,
  });

  final TextEditingController descriptionController;
  final Function saveDescription;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            'Описание',
            style: TextStyle(
              fontSize: 24,
              fontFamily: fontApp,
              fontWeight: FontWeight.bold,
              color: AppColors.onBackground,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: descriptionController,
              style: const TextStyle(
                fontFamily: fontApp,
                fontWeight: FontWeight.normal,
              ),
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Описание',
                labelStyle: const TextStyle(
                  fontFamily: fontApp,
                  fontWeight: FontWeight.normal,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Stack(
            children: [
              Container(
                width: 200,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(
                width: 200,
                height: 45,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Подтвердить',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: fontApp,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    saveDescription(
                      descriptionUpdate: descriptionController.text,
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
