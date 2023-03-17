import 'package:code_hero_project/app/models/model_retorno_personagens.dart';
import 'package:code_hero_project/utils/enums/model_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:code_hero_project/app/pages/home/home_repository.dart';

class HomeController extends ChangeNotifier {
  final repository = HomeRepository();

  final nomePersonagemBuscar = TextEditingController();

  //! valida estados da aplicação
  modelState state = modelState.stopped;

  //! Models retorno API
  ModelPersonagensMarvel? buscaPersonagensRetorno;

  // //! Buscar personagem da lista
  List<Character?> personagensFiltrados = [];
  List<Character?> personagens = [];

  buscaPersonagemLista() {
    if (nomePersonagemBuscar.text.isEmpty) {
      personagensFiltrados = buscaPersonagensRetorno!.data.results;
    } else {
      List<Character> listaFiltrada = [];
      for (int i = 0; i < buscaPersonagensRetorno!.data.results.length; i++) {
        if (buscaPersonagensRetorno!.data.results
            .elementAt(i)
            .name
            .toLowerCase()
            .contains(nomePersonagemBuscar.text.toLowerCase())) {
          listaFiltrada.add(buscaPersonagensRetorno!.data.results.elementAt(i));
        }
      }
      personagensFiltrados = listaFiltrada;
    }
    notifyListeners();
  }

  //! metodo GET busca personagem
  Future<dynamic>? buscaPersonagens() async {
    if (state == modelState.loading) return;

    try {
      state = modelState.loading;
      notifyListeners();
      buscaPersonagensRetorno = await repository.getBuscaPersonagens();

      personagens = buscaPersonagensRetorno!.data.results;
      personagensFiltrados = personagens;

      // _totalPaginas = (personagensFiltrados.length / 4).ceil();

      state = modelState.success;
    } on DioError {
      state = modelState.error;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    } finally {
      notifyListeners();
    }
  }

  //! Paginação
  int paginaAtual = 1;

  void setPaginaAtual(int index) {
    paginaAtual = index;
    notifyListeners();
  }

  List<Character?>? getPersonagensPagina(int pagina) {
    notifyListeners();
    final startIndex = (pagina - 1) * 4;
    final endIndex = startIndex + 4;

    if (endIndex > personagensFiltrados.length) {
      return personagensFiltrados.sublist(startIndex);
    } else {
      return personagensFiltrados.sublist(startIndex, endIndex);
    }
  }
}
