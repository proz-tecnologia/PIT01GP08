import 'package:financial_app/design_sys/sizes.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/month_changer.dart';
import 'total_tile.dart';

class ResumeInfoWidget extends StatefulWidget {
  const ResumeInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ResumeInfoWidget> createState() => _ResumeInfoWidgetState();
}

class _ResumeInfoWidgetState extends State<ResumeInfoWidget> {
  bool visible = true;
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                MonthChanger('Dezembro'),
              ],
            ),
            SizedBox(height: spaceBetween),
            Row(
              children: [
                Expanded(flex: 1, child: Container()),
                TotalTile(
                  label: 'Saldo',
                  value: 'R\$ 2600,00',
                  visible: visible,
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                    icon: Icon(
                      visible ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spaceBetween),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TotalTile(
                  icon: Icons.arrow_downward,
                  label: 'Despesas',
                  value: 'R\$ 150,00',
                  visible: visible,
                ),
                TotalTile(
                  icon: Icons.arrow_upward,
                  label: 'Receitas',
                  value: 'R\$ 1000,00',
                  visible: visible,
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
