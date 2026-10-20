import '../models/categoria.dart';

abstract class CategoriaState {}

class CategoriaInitial extends CategoriaState {}

class CategoriaLoading extends CategoriaState {}

class CategoriaLoaded extends CategoriaState {
  final List<Categoria> categorias;
  CategoriaLoaded(this.categorias);
}

class CategoriaSuccess extends CategoriaState {
  final String mensagem;
  CategoriaSuccess(this.mensagem);
}

class CategoriaError extends CategoriaState {
  final String erro;
  CategoriaError(this.erro);
}