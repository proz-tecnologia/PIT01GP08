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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 80,
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
                const SizedBox(
                  width: 80,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width,
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
          SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            color: AppColors.primary,
            child: Row(
              children: [
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
                const SizedBox(
                  width: 60,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
