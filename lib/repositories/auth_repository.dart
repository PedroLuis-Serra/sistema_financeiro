import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class AuthRepository {
  static const String _baseUrl = "https://eihcpfgoqplukrxtakcy.supabase.co/auth/v1";
  static const String _publishableKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVpaGNwZmdvcXBsdWtyeHRha2N5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTIxMDQ1NzUsImV4cCI6MjEwNzY4MDU3NX0.f_UHUNVd-u790-aL2bKZnUmpB6Lbo2Jmmqjszz_wRQk";

  Map<String, String> get _headers => {
    'apikey': _publishableKey,
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  Future<void> cadastrar({
    required String email,
    required String senha
  }) async {

    final response = await http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: _headers,
      body: jsonEncode({
        'email': email,
        'password': senha
      })
    );

    if (response.statusCode != 200) {
      final erro = jsonDecode(response.body);
      throw Exception(erro['msg'] ?? 'Erro ao realizar o cadastro.');
    }

  }

  Future<Usuario> login({
    required String email,
    required String senha
  }) async {

    final response = await http.post(
      Uri.parse('$_baseUrl/token?grant_type=password'),
      headers: _headers,
      body: jsonEncode({
        'email': email,
        'password': senha
      })
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Usuario.fromJson(data);
    } else {
      throw Exception(data['error_description'] ?? 'Falha ao realizar o login.');
    }
  }
}