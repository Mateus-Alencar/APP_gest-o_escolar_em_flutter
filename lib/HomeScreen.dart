import 'package:flutter/material.dart';
import 'EducadoresScreen.dart'; 
import 'Educadores.dart';
import 'ScreenLogin.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Inicial'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botão de Adicionar Educador
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EducatorsScreen()), // Navegação para EducatorsScreen
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900], // Cor azul do botão
                      minimumSize: Size(double.infinity, 50), // Largura total
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Adicionar Educador',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              // Botão de Listar Educadores
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EducatorsListaScreen()), // Navegação para EducatorsListaScreen
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900], // Cor azul do botão
                      minimumSize: Size(double.infinity, 50), // Largura total
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Listar Educadores',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              // Botão de Logout com altura fixa
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: double.infinity, // Largura total para o botão de logout
                  height: 100, // Altura fixa para o botão de logout
                  child: ElevatedButton(
                    onPressed: () {
                      // Função de logout para voltar à tela de login
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ScreenLogin()), // Redireciona para a tela de login
                        (Route<dynamic> route) => false, // Remove todas as rotas anteriores
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[900], // Cor vermelha do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
