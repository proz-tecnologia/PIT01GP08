import 'package:financial_app/design_sys/sizes.dart';
import 'package:flutter/material.dart';

class ResumeInfoWidget extends StatefulWidget {
  const ResumeInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ResumeInfoWidget> createState() => _ResumeInfoWidgetState();
}

class _ResumeInfoWidgetState extends State<ResumeInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final spaceBetween = height * Sizes.threePercent;
    return Container(
      margin: EdgeInsets.only(bottom: spaceBetween),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: spaceBetween),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                IconButton(
                    color: Theme.of(context).colorScheme.onPrimary,
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios)),
                Text(
                  'Dezembro',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                    color: Theme.of(context).colorScheme.onPrimary,
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios)),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
            SizedBox(height: spaceBetween),
            Text(
              'Saldo',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'R\$ 2600,00',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spaceBetween),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.all(Sizes.smallSpace),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        size: Sizes.mediumIconSize,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Receitas',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'RS 1000,00',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.all(Sizes.smallSpace),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_downward,
                        size: Sizes.mediumIconSize,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Despesas',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'RS 150,00',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
            SizedBox(height: spaceBetween),
          ],
        ),
      ),
    );
  }
}
