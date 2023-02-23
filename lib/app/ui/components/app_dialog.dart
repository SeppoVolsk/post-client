import 'package:chat_client/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_text_button.dart';
import 'app_text_field.dart';

class AppDialog extends StatefulWidget {
  const AppDialog({
    super.key,
    required this.val1,
    required this.val2,
    required this.onPressed,
  });

  final String val1;
  final String val2;
  final Function(String v1, String v2) onPressed;

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  final val1Controller = TextEditingController();
  final val2Controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AppTextField(
                    controller: val1Controller, labelText: widget.val1),
                const SizedBox(height: 16),
                AppTextField(
                    controller: val2Controller, labelText: widget.val2),
                const SizedBox(height: 16),
                AppTextButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        Navigator.pop(context);
                        widget.onPressed(
                            val1Controller.text, val2Controller.text);
                      }
                    },
                    text: "Apply"),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    val1Controller.dispose();
    val2Controller.dispose();
    super.dispose();
  }
}
