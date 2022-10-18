import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/material.dart';

import 'widgets/item_to_expansion_panel.dart';

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
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      borderOnForeground: false,
      elevation: 2,
      color: AppColors.primary,
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
            ),
            TextButton(onPressed: () {}, child: Text("Dezembro"))
          ],
        ),
      ),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(16),
//       child: InkWell(
//         onTap: () {
//           //TODO: navigation
//         },
//         child: SizedBox(
//           height: 195,
//           child: 
//         ),
//       ),
//     );
//   }
// }