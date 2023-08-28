import 'package:flutter/material.dart';

class UserRegisterPage extends StatelessWidget {
  const UserRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(label: Text('Nome')),
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(label: Text('E-mail')),
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(label: Text('Senha')),
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration:
                    const InputDecoration(label: Text('Confirmar a senha')),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56)),
                onPressed: () {},
                child: const Text('CRIAR CONTA'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
