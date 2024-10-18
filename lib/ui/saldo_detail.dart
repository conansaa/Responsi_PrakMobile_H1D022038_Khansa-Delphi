import 'package:flutter/material.dart';
import 'package:saldo/bloc/balance_bloc.dart';
import 'package:saldo/model/saldo.dart';
import 'package:saldo/ui/saldo_form.dart';
import 'package:saldo/ui/saldo_page.dart';
import 'package:saldo/widget/warning_dialog.dart';

// ignore: must_be_immutable
class BalanceDetail extends StatefulWidget {
  Balance? balance;
  BalanceDetail({Key? key, this.balance}) : super(key: key);

  @override
  _BalanceDetailState createState() => _BalanceDetailState();
}

class _BalanceDetailState extends State<BalanceDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Saldo',
          style: TextStyle(fontFamily: 'Comic Sans MS'),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Akun : ${widget.balance!.account}",
              style: const TextStyle(fontSize: 20.0, fontFamily: 'Comic Sans MS'),
            ),
            Text(
              "Saldo : Rp. ${widget.balance!.balance.toString()}",
              style: const TextStyle(fontSize: 18.0, fontFamily: 'Comic Sans MS'),
            ),
            Text(
              "Status : ${widget.balance!.status}",
              style: const TextStyle(fontSize: 18.0, fontFamily: 'Comic Sans MS'),
            ),
            const SizedBox(height: 20),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text(
            "EDIT",
            style: TextStyle(fontFamily: 'Comic Sans MS'),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BalanceForm(
                  balance: widget.balance!,
                ),
              ),
            );
          },
          style: OutlinedButton.styleFrom(foregroundColor: Colors.orange),
        ),

        const SizedBox(width: 10),

        // Tombol Hapus
        OutlinedButton(
          child: const Text(
            "DELETE",
            style: TextStyle(fontFamily: 'Comic Sans MS'),
          ),
          onPressed: () => confirmHapus(),
          style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(fontFamily: 'Comic Sans MS'),
      ),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text(
            "Ya",
            style: TextStyle(fontFamily: 'Comic Sans MS'),
          ),
          onPressed: () {
            BalanceBloc.deleteBalance(id: (widget.balance!.id!)).then((value) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SaldoPage()));
            }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ));
            });
          },
          style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
        ),

        // Tombol batal
        OutlinedButton(
          child: const Text(
            "Batal",
            style: TextStyle(fontFamily: 'Comic Sans MS'),
          ),
          onPressed: () => Navigator.pop(context),
          style: OutlinedButton.styleFrom(foregroundColor: Colors.blue),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
