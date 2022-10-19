import 'package:financial_app/design_sys/colors.dart';
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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 250,
      width: MediaQuery.of(context).size.width,
      color: AppColors.primary,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                IconButton(
                    color: AppColors.white,
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios)),
                const Text(
                  'Dezembro',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                    color: AppColors.white,
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios)),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
            const SizedBox(
              height: 45,
            ),
            const Text(
              'Saldo',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(
              'R\$ 2600,00',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Container(
              color: AppColors.primary,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_upward,
                          size: 30,
                          color: AppColors.white,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Text(
                              'Receitas',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'RS 1000,00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_downward,
                          size: 30,
                          color: AppColors.white,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Text(
                              'Despesas',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'RS 150,00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
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
            ),
          ],
        ),
      ),
    );
  }
}
