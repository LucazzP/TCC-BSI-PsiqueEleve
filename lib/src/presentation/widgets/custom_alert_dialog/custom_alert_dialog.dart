import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomAlertDialog {
  static Future<void> createdUser(BuildContext context, String password) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Usuário criado com sucesso'),
        alignment: Alignment.center,
        content: Text.rich(
          TextSpan(
            text: 'Anote a senha do usuário:\n',
            children: [
              TextSpan(
                text: password,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: '\n\nA senha já foi copiada para a área de transferência.'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Copiar'),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: password));
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Modular.to.pop();
            },
          ),
        ],
      ),
    );
  }
}
