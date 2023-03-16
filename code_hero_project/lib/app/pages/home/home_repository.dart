import 'package:code_hero_project/app/models/model_retorno_personagens.dart';
import 'package:code_hero_project/const/env.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class HomeRepository {
  final dio = Dio();

  //! Listar persomagems
  List<Character?> personagens = [];

  //! criação de um hash com base nos requisitos da API: ts + privatekey + publicKey
  final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  late String hash = timestamp + Env.privateKey + Env.publicKey;
  String textToMd5(String hash) {
    return md5.convert(utf8.encode(hash)).toString();
  }

  //! Método GET para buscar personagens
  Future<ModelPersonagensMarvel?> getBuscaPersonagens() async {
    final queryParameters = {
      "apikey": Env.publicKey,
      "ts": timestamp,
      "hash": textToMd5(hash),
    };
    try {
      Response response = await dio.get(
        Env.urlBase,
        options: Options(
            contentType: 'application/json', responseType: ResponseType.json),
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        final saida = ModelPersonagensMarvel.fromJson(response.data);
        personagens.addAll(saida.data.results);
        return saida;
      }
    } on DioError catch (exc) {
      throw ('Exception ${exc.message}');
    }
    return null;
  }
}
