import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class GeneralExceptionWidget extends StatefulWidget {
  final VoidCallback? onPress;
  const GeneralExceptionWidget({super.key, this.onPress});

  @override
  State<GeneralExceptionWidget> createState() =>
      _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<GeneralExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: Icon(
              Icons.cloud_off,
              color: Colors.red,
              size: 100,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Some Thing went wrong\n Pease Try after some time.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: widget.onPress,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.sizeOf(context).width * 0.5,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                "Retry",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
