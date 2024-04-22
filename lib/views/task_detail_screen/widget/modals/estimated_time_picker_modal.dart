import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/utils/utils.dart';

class EstimatedTimePickerModal extends StatelessWidget {
  const EstimatedTimePickerModal({
    super.key,
    required this.hoursController,
    required this.minutesController,
    required this.saveEstimate,
  });

  final TextEditingController hoursController, minutesController;
  final Function saveEstimate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            'Время выполнения',
            style: TextStyle(
              fontSize: 24,
              fontFamily: fontApp,
              fontWeight: FontWeight.bold,
              color: AppColors.onBackground,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 40),
            child: Container(
              height: 1,
              color: AppColors.onBackground.withOpacity(0.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: hoursController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontFamily: fontApp,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Часы',
                      labelStyle: const TextStyle(
                        fontFamily: fontApp,
                        fontWeight: FontWeight.normal,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: minutesController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^[0-5]?[0-9]$'),
                      ),
                    ],
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontFamily: fontApp,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Минуты',
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
              ],
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
                    saveEstimate(
                      newEstimate:
                          '${hoursController.text}ч ${minutesController.text}мин',
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
