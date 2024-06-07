// services/chemical_element_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

class ChemicalElementService {
  static const String apiUrl = 'https://kineticzephyr.onrender.com/periodictable/';

  static Future<List<ChemicalElement>> fetchElements() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> elementsJson = jsonResponse['data'];

      return elementsJson.map((element) => ChemicalElement.fromJson(element)).toList();
    } else {
      throw Exception('Failed to load elements');
    }
  }
}
