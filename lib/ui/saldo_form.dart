import 'package:flutter/material.dart';
import 'package:saldo/bloc/balance_bloc.dart';
import 'package:saldo/model/saldo.dart';
import 'package:saldo/ui/saldo_page.dart';
import 'package:saldo/widget/warning_dialog.dart';

// ignore: must_be_immutable
class BalanceForm extends StatefulWidget {
  Balance? balance;
  BalanceForm({Key? key, this.balance}) : super(key: key);

  @override
  _BalanceFormState createState() => _BalanceFormState();
}

class _BalanceFormState extends State<BalanceForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH SALDO";
  String tombolSubmit = "SIMPAN";
  final _accountTextboxController = TextEditingController();
  final _balanceTextboxController = TextEditingController();
  final _statusTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.balance != null) {
      setState(() {
        judul = "UBAH SALDO";
        tombolSubmit = "UBAH";
        _accountTextboxController.text = widget.balance!.account;
        _balanceTextboxController.text = widget.balance!.balance.toString();
        _statusTextboxController.text = widget.balance!.status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
          style: const TextStyle(fontFamily: 'Comic Sans MS'),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _accountTextField(),
                _balanceTextField(),
                _statusTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Account
  Widget _accountTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Akun",
        labelStyle: TextStyle(fontFamily: 'Comic Sans MS'),
      ),
      keyboardType: TextInputType.text,
      controller: _accountTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Akun harus diisi";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Comic Sans MS'),
    );
  }

  // Membuat Textbox Balance
  Widget _balanceTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Saldo",
        labelStyle: TextStyle(fontFamily: 'Comic Sans MS'),
      ),
      keyboardType: TextInputType.number,
      controller: _balanceTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Saldo harus diisi";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Comic Sans MS'),
    );
  }

  // Membuat Textbox Status
  Widget _statusTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Status",
        labelStyle: TextStyle(fontFamily: 'Comic Sans MS'),
      ),
      keyboardType: TextInputType.text,
      controller: _statusTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Status harus diisi";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Comic Sans MS'),
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(
        tombolSubmit,
        style: const TextStyle(fontFamily: 'Comic Sans MS'),
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.balance != null) {
              // kondisi update saldo
              ubah();
            } else {
              // kondisi tambah saldo
              simpan();
            }
          }
        }
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.orange,
      ),
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });
    Balance createBalance = Balance(
      account: _accountTextboxController.text,
      balance: int.parse(_balanceTextboxController.text),
      status: _statusTextboxController.text,
    );
    BalanceBloc.addBalance(balance: createBalance).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const SaldoPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });
    Balance updateBalance = Balance(
      id: widget.balance!.id!,
      account: _accountTextboxController.text,
      balance: int.parse(_balanceTextboxController.text),
      status: _statusTextboxController.text,
    );
    BalanceBloc.updateBalance(balance: updateBalance).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const SaldoPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
