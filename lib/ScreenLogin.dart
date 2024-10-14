import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'HomeScreen.dart';

class ScreenLogin extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Por favor, preencha todos os campos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      try {
        final response = await Supabase.instance.client
            .from('educators')
            .select()
            .eq('email', email)
            .eq('senha', password)
            .single(); // Retorna apenas um resultado

        if (response == null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Erro'),
              content: Text('Credenciais inválidas. Verifique seu email ou senha.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          // Sucesso, navega para a próxima tela
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } catch (e) {
        // Exibir mensagem de erro em caso de exceção
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erro'),
            content: Text('Ocorreu um erro no login: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ESCRIBO',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'nome@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: '*******',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => login(context), // Chamando a função login
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900], // Cor azul como na imagem
                  minimumSize: Size(double.infinity, 50), // Botão preenchendo a largura
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
