import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EducatorsScreen extends StatefulWidget {
  const EducatorsScreen({super.key});

  @override
  _EducatorsScreenState createState() => _EducatorsScreenState();
}

class _EducatorsScreenState extends State<EducatorsScreen> {
  // Variáveis para armazenar os dados do formulário
  String nomeCompleto = '';
  String email = '';
  String telefone = '';
  String? papel; // Coordenador ou Professor
  String? periodoSelecionado;
  String? classeSelecionada; // Adicionando a variável para classe
  String senha = ''; // Variável para a senha

  final List<String> periodos = ['Manhã', 'Tarde', 'Noite'];
  final List<String> classes = ['Classe A', 'Classe B', 'Classe C']; // Lista de classes

  void salvar() async {
    // Verifica se os campos foram preenchidos
    if (nomeCompleto.isEmpty || email.isEmpty || periodoSelecionado == null || classeSelecionada == null || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    try {
      await Supabase.instance.client.from('educators').insert({
        'full_name': nomeCompleto,
        'email': email,
        'phone': telefone,
        'role': papel == 'Sim' ? 'Coordenador' : 'Professor',
        'period': periodoSelecionado,
        'classe': classeSelecionada,
        'senha': senha, 
      });

      // Limpa os campos após salvar
      setState(() {
        nomeCompleto = '';
        email = '';
        telefone = '';
        papel = null;
        periodoSelecionado = null;
        classeSelecionada = null;
        senha = '';
      });

      // Exibe mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Educador salvo com sucesso!')),
      );

      // Volta para a tela inicial
      Navigator.of(context).pop(); // Retorna à tela anterior
    } catch (e) {
      // Tratar erro na inserção
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar educador: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Educador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'EDUCADORES\nPreencha os dados solicitados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nome completo',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  nomeCompleto = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'E-mail da escola',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Telefone (opcional)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  telefone = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Coordenador',
                border: OutlineInputBorder(),
              ),
              items: const <String>['Sim', 'Não']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  papel = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Período',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              children: periodos.map((periodo) {
                return RadioListTile<String>(
                  title: Text(periodo),
                  value: periodo,
                  groupValue: periodoSelecionado,
                  onChanged: (String? value) {
                    setState(() {
                      periodoSelecionado = value;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Classe',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Selecione a classe',
                border: OutlineInputBorder(),
              ),
              items: classes
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  classeSelecionada = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // Para ocultar a senha
              onChanged: (value) {
                setState(() {
                  senha = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvar,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
