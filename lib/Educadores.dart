import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EducatorsListaScreen extends StatefulWidget {
  const EducatorsListaScreen({super.key});

  @override
  _EducatorsListaScreenState createState() => _EducatorsListaScreenState();
}

class _EducatorsListaScreenState extends State<EducatorsListaScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? selectedPeriod;
  String? selectedClass;
  List<dynamic> educators = [];
  List<dynamic> filteredEducators = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEducators(); // Buscar todos os educadores inicialmente
  }

  Future<void> fetchEducators({
    String? name,
    String? period,
    String? className,
  }) async {
    setState(() {
      isLoading = true;
    });

    try {
      var query = Supabase.instance.client
          .from('educators')
          .select('id, full_name, email, phone, role, period, senha, classe'); // Seleciona a classe diretamente da tabela educators

      // Aplica os filtros de nome, período e classe, se existirem
      if (name != null && name.isNotEmpty) {
        query = query.ilike('full_name', '%$name%'); // Filtro por nome
      }
      if (period != null && period.isNotEmpty) {
        query = query.eq('period', period); // Filtro por período
      }
      if (className != null && className.isNotEmpty) {
        query = query.eq('classe', className); // Filtro por classe
      }

      final response = await query; // Execute a consulta

      if (response != null && response.isNotEmpty) {
        setState(() {
          educators = response as List<dynamic>;
          filteredEducators = educators; // Começa com todos os educadores
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          filteredEducators = []; // Se não houver resultados, limpa a lista
        });
        print('Nenhum educador encontrado');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Erro ao buscar educadores: $e');
    }
  }

  // Função de filtro
  void applyFilters() {
    fetchEducators(
      name: _nameController.text,
      period: selectedPeriod,
      className: selectedClass, // Passa o filtro da classe
    );
  }

  // Função para excluir educador
  Future<void> deleteEducator(int id) async {
    try {
      final response = await Supabase.instance.client
          .from('educators')
          .delete()
          .eq('id', id);
      print('Educador deletado: $id');
      // Após a exclusão, atualize a lista
      fetchEducators();
    } catch (e) {
      print('Erro ao deletar educador: $e');
    }
  }

  // Função para editar educador (abre a caixa de diálogo)
  void editEducator(dynamic educator) {
    TextEditingController fullNameController = TextEditingController(text: educator['full_name']);
    TextEditingController emailController = TextEditingController(text: educator['email']);
    TextEditingController phoneController = TextEditingController(text: educator['phone']);
    String? selectedRole = educator['role'];
    String? selectedPeriodEdit = educator['period'];
    String? selectedClassEdit = educator['classe'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Educador'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome completo',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedPeriodEdit,
                  decoration: const InputDecoration(
                    labelText: 'Período',
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['Manhã', 'Tarde', 'Noite']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedPeriodEdit = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedClassEdit,
                  decoration: const InputDecoration(
                    labelText: 'Classe',
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['Classe A', 'Classe B', 'Classe C']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedClassEdit = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o modal
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // salvar as alterações no banco de dados
                updateEducator(
                  educator['id'],
                  fullNameController.text,
                  emailController.text,
                  phoneController.text,
                  selectedPeriodEdit,
                  selectedClassEdit,
                );
                Navigator.of(context).pop(); // Fecha o modal
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Função para atualizar o educador
  Future<void> updateEducator(
    int id,
    String fullName,
    String email,
    String phone,
    String? period,
    String? className,
  ) async {
    try {
      final response = await Supabase.instance.client
          .from('educators')
          .update({
            'full_name': fullName,
            'email': email,
            'phone': phone,
            'period': period,
            'classe': className,
          })
          .eq('id', id);
      print('Educador atualizado: $id');
      fetchEducators(); // Atualiza a lista após a edição
    } catch (e) {
      print('Erro ao atualizar educador: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educadores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome do educador',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => applyFilters(), // Aplica o filtro ao digitar
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Período',
                border: OutlineInputBorder(),
              ),
              items: <String>['Manhã', 'Tarde', 'Noite']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedPeriod = value;
                });
                applyFilters();
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Classe',
                border: OutlineInputBorder(),
              ),
              items: <String>['Classe A', 'Classe B', 'Classe C']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedClass = value;
                });
                applyFilters();
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredEducators.length,
                      itemBuilder: (context, index) {
                        final educator = filteredEducators[index];
                        return ListTile(
                          title: Text(educator['full_name']),
                          subtitle: Text(
                              'Email: ${educator['email']}\nPeríodo: ${educator['period']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => editEducator(educator),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteEducator(educator['id']),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
