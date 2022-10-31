import 'package:financial_app/design_sys/colors.dart';
import 'package:financial_app/design_sys/sizes.dart';
import 'package:flutter/material.dart';

class AppPending extends StatelessWidget {
  const AppPending({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.smallSpace),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.mediumSpace),
                child: Column(
                  children: const [
                    Icon(
                      Icons.download_rounded,
                      size: Sizes.largeIconSize,
                      color: AppColors.expense,
                    ),
                    Text('Pagar'),
                    Text(
                      'RS 1000,00',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.expense,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.mediumSpace),
                child: Column(
                  children: const [
                    Icon(
                      Icons.publish_rounded,
                      size: Sizes.largeIconSize,
                      color: AppColors.income,
                    ),
                    Text('Receber'),
                    Text(
                      'RS 1000,00',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.income,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
