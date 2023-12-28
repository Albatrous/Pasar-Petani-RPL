import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pasar_petani/config/constants.dart';

enum StatusPermintaan {
  diproses,
  ditolak,
  diterima,
}

class Status extends http.BaseClient {
  http.Client client = http.Client();
  final String _baseUrl = '$BACKEND_URL/api';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${storage.read('access_token')}'
  };

  Status();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return client.send(request);
  }

  Future<void> payment(int idMoney, String nominal) async {
    Future<http.Response> result = http.post(
      Uri.parse('$_baseUrl/saldo/kirim/$idMoney'),
      headers: headers,
      body: jsonEncode({
        'nominal_pemasukan': nominal,
      }),
    );

    result.then((value) {
      if (kDebugMode) {
        print(value.body);
      }
    });
  }

  void addStatus(int idPermintaan, StatusPermintaan status) {
    String keterangan = '';
    String statusString = 'baru';
    switch (status) {
      case StatusPermintaan.diproses:
        keterangan = 'Permintaan sedang diproses';
        statusString = 'diproses';
        break;
      case StatusPermintaan.ditolak:
        keterangan = 'Permintaan kamu ditolak';
        statusString = 'ditolak';
        break;
      case StatusPermintaan.diterima:
        keterangan = 'Permintaan kamu diterima';
        statusString = 'diterima';
        break;
    }
    Future<http.Response> result = http.post(
      Uri.parse('$_baseUrl/status/add'),
      headers: headers,
      body: jsonEncode({
        'id_permintaan': idPermintaan.toInt(),
        'keterangan': keterangan,
        'status': statusString,
        'tgl_perubahan': DateTime.now().toIso8601String(),
      }),
    );

    result.then((value) {
      if (kDebugMode) {
        print(value.body);
      }
    });
  }
}
