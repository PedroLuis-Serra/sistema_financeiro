import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/categoria.dart';
import '../repositories/categoria_repository.dart';
import 'categoria_state.dart';

class CategoriaCubit extends Cubit<CategoriaState> {
  List<Categoria> _categorias = [];
  final CategoriaRepository repository;

  CategoriaCubit({required this.repository}) : super(CategoriaInitial());

  Future<void> carregarCategorias() async {
    emit(CategoriaLoading());
    try {
      _categorias = await repository.buscarCategorias();
      emit(CategoriaLoaded(List.unmodifiable(_categorias)));
    } catch (e) {
      emit(CategoriaError('Erro ao carregar categorias. $e'));
    }
  }

  Future<void> adicionarCategoria(String nome) async {
    if (nome.trim().isEmpty) {
      emit(CategoriaError('O nome da categoria não pode ser vazio.'));
      return;
    }

    emit(CategoriaLoading());

    try {
      final novaCategoria = await repository.criarCategoria(
        Categoria(id: '', nome: nome.trim()),
      );
      _categorias.add(novaCategoria);
      emit(CategoriaSuccess(
          'Categoria "${novaCategoria.nome}" cadastrada com sucesso!'));
      emit(CategoriaLoaded(List.unmodifiable(_categorias)));
    } catch (e) {
      emit(CategoriaError('Erro ao salvar categoria. $e'));
    }
  }
}