import 'dart:convert';
import 'package:saldo/helpers/api.dart';
import 'package:saldo/helpers/api_url.dart';
import 'package:saldo/model/saldo.dart';

class BalanceBloc {
  // Method to fetch all balances from the API
  static Future<List<Balance>> getBalances() async {
    String apiUrl = ApiUrl.listBalance; // URL for fetching balance data
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listBalance = (jsonObj as Map<String, dynamic>)['data'];
    List<Balance> balances = [];
    for (int i = 0; i < listBalance.length; i++) {
      balances.add(Balance.fromJson(listBalance[i]));
    }
    return balances;
  }

  // Method to add a new balance entry
  static Future addBalance({Balance? balance}) async {
    String apiUrl = ApiUrl.createBalance; // URL for adding balance
    var body = {
      "account": balance!.account,
      "balance": balance.balance.toString(),
      "status": balance.status
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status']; // Return status from the API
  }

  // Method to update an existing balance entry
  static Future updateBalance({required Balance balance}) async {
    String apiUrl = ApiUrl.updateBalance(balance.id!); // URL for updating balance
    var body = {
      "account": balance.account,
      "balance": balance.balance.toString(),
      "status": balance.status
    };
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status']; // Return status from the API
  }

  // Method to delete a balance entry
  static Future<bool> deleteBalance({int? id}) async {
    String apiUrl = ApiUrl.deleteBalance(id!); // URL for deleting balance
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['status']; // Return true/false based on status
  }
}
