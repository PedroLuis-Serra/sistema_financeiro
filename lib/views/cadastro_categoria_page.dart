import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/categoria_cubit.dart';
import '../cubits/categoria_state.dart';

class CadastroCategoriaPage extends StatefulWidget {
  const CadastroCategoriaPage({super.key});

  @override
  State<CadastroCategoriaPage> createState() => _CadastroCategoriaPageState();
}

class _CadastroCategoriaPageState extends State<CadastroCategoriaPage> {
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CategoriaCubit>().carregarCategorias();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Categorias"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: BlocListener<CategoriaCubit, CategoriaState>(
          listener: (context, state) {
            if (state is CategoriaSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.mensagem),
                  backgroundColor: Colors.green,
                ),
              );
            }
            if (state is CategoriaError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.erro),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome da Categoria',
                    prefixIcon: Icon(Icons.category_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    context
                        .read<CategoriaCubit>()
                        .adicionarCategoria(_nomeController.text);
                    _nomeController.clear();
                  },
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text(
                    'Salvar Categoria',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Categorias cadastradas",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: BlocBuilder<CategoriaCubit, CategoriaState>(
                    builder: (context, state) {
                      if (state is CategoriaLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is CategoriaLoaded) {
                        if (state.categorias.isEmpty) {
                          return const Center(
                            child: Text(
                              "Nenhuma categoria registrada.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: state.categorias.length,
                          itemBuilder: (context, index) {
                            final categoria = state.categorias[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.teal,
                                  child: Icon(Icons.label_outline,
                                      color: Colors.white),
                                ),
                                title: Text(
                                  categoria.nome,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}