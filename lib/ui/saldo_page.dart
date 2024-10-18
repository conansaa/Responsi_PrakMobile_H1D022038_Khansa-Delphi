import 'package:flutter/material.dart';
import 'package:saldo/model/saldo.dart';
import 'package:saldo/ui/saldo_form.dart';
import 'package:saldo/ui/login_page.dart';
import 'package:saldo/ui/saldo_detail.dart';
import 'package:saldo/bloc/balance_bloc.dart';
import 'package:saldo/bloc/logout_bloc.dart';

class SaldoPage extends StatefulWidget {
  const SaldoPage({Key? key}) : super(key: key);

  @override
  _SaldoPageState createState() => _SaldoPageState();
}

class _SaldoPageState extends State<SaldoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Saldo',
          style: TextStyle(fontFamily: 'Comic Sans MS'),
        ),
        backgroundColor: Colors.orange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                // Aksi untuk menambahkan saldo baru
                Navigator.push(context, MaterialPageRoute(builder: (context) => BalanceForm())); // Ganti dengan widget form untuk menambah saldo
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                          (route) => false)
                });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Balance>>(
        future: BalanceBloc.getBalances(), // Mengambil data dari API
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? ListSaldo(list: snapshot.data) // Menggunakan ListSaldo dengan Balance
              : const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ListSaldo extends StatelessWidget {
  final List<Balance>? list;

  const ListSaldo({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemSaldo(balance: list![i]);
      },
    );
  }
}

class ItemSaldo extends StatelessWidget {
  final Balance balance; // Ubah nama variabel dari saldo menjadi balance

  const ItemSaldo({Key? key, required this.balance}) : super(key: key); // Ubah nama variabel dari saldo menjadi balance

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Aksi ketika item saldo ditekan
        Navigator.push(context, MaterialPageRoute(builder: (context) => BalanceDetail(balance: balance))); // Ganti dengan widget detail saldo
      },
      child: Card(
        color: Colors.yellow[100], // Warna dasar kuning
        child: ListTile(
          title: Text(
            balance.account, // Menggunakan balance
            style: const TextStyle(
              fontFamily: 'Comic Sans MS',
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Saldo: ${balance.balance}', // Menggunakan balance
            style: const TextStyle(
              fontFamily: 'Comic Sans MS',
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}
