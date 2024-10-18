class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/api';
  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String listBalance = '$baseUrl/keuangan/saldo'; // Endpoint untuk mengambil daftar saldo
  static const String createBalance = '$baseUrl/keuangan/saldo'; // Endpoint untuk menambah saldo

  static String updateBalance(int id) {
    return '$baseUrl/keuangan/saldo/$id/update'; // Endpoint untuk memperbarui saldo berdasarkan ID
  }

  static String showBalance(int id) {
    return '$baseUrl/keuangan/saldo/$id'; // Endpoint untuk menampilkan detail saldo berdasarkan ID
  }

  static String deleteBalance(int id) {
    return '$baseUrl/keuangan/saldo/$id/delete'; // Endpoint untuk menghapus saldo berdasarkan ID
  }
}
