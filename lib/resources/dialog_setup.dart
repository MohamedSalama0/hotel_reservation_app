
import 'package:flutter/material.dart';

class TopLoader {
  static const SizedBox _container = SizedBox(
    width: 40,
    height: 40,
    child: Center(
      child: CircularProgressIndicator(color: Colors.blueGrey),
    ),
  );

  static void startLoading(BuildContext context) {
    showDialog(
      barrierColor: Colors.black54,
      barrierDismissible: false,
      context: context,
      builder: (context) => _container,
    );
  }

  static void stopLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}

Future<void> showResponseDialog({
  required BuildContext context,
  required String responseMessage,
  required bool status,
  Widget? child,
  bool barrierDismissible = true,
}) async {
  final size = MediaQuery.of(context).size;
  final orientation = MediaQuery.of(context).orientation;
  final dialog = Dialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width:
            (orientation == Orientation.portrait ? size.width : size.height) *
                .7,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 25),
              status
                  ? const Icon(
                      Icons.done,
                      size: 40,
                    )
                  : const Text('Error'),
              const SizedBox(height: 20),
              Text(
                responseMessage,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              if (child != null) ...[const SizedBox(height: 10), child],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
  );
  await showDialog(
    context: context,
    builder: (context) => dialog,
    barrierDismissible: barrierDismissible,
  );
}
