import 'dart:io';

typedef Matkul = ({String nama, int sks, String huruf});

const skalaBobot = {'A': 4, 'B': 3, 'C': 2, 'D': 1, 'E': 0};

String baca(String label) {
  stdout.write('$label : ');
  return (stdin.readLineSync() ?? '').trim();
}

// Validasi: melempar exception bila input salah
int validasiSks(String teks) {
  final sks = int.tryParse(teks);
  if (sks == null || sks < 1 || sks > 6) {
    throw FormatException('SKS harus berupa angka 1-6, bukan "$teks".');
  }
  return sks;
}

String validasiNilai(String teks) {
  final huruf = teks.toUpperCase();
  if (!skalaBobot.containsKey(huruf)) {
    throw FormatException('Nilai harus A/B/C/D/E, bukan "$teks".');
  }
  return huruf;
}

// '!' aman: huruf sudah lolos validasiNilai, jadi pasti ada di skalaBobot
int bobot(String huruf) => skalaBobot[huruf]!;

double hitungIp(List<Matkul> data) {
  final totalSks = data.fold<int>(0, (s, m) => s + m.sks);
  final poin = data.fold<int>(0, (s, m) => s + m.sks * bobot(m.huruf));
  return totalSks == 0 ? 0 : poin / totalSks;
}

String predikat(double ip) => switch (ip) {
  >= 3.5 => 'Sangat Memuaskan',
  >= 3.0 => 'Memuaskan',
  >= 2.0 => 'Cukup',
  _ => 'Kurang',
};

void cetakKhs(List<Matkul> data, {bool urutkan = false}) {
  final daftar = [...data];
  if (urutkan) {
    // fungsi pembanding: nilai tertinggi di atas
    daftar.sort((a, b) => bobot(b.huruf).compareTo(bobot(a.huruf)));
  }

  print(
    '\n${'Mata Kuliah'.padRight(26)}${'SKS'.padLeft(4)}${'Nilai'.padLeft(7)}',
  );
  print('-' * 37);
  for (final m in daftar) {
    print(
      '${m.nama.padRight(26)}${m.sks.toString().padLeft(4)}${m.huruf.padLeft(7)}',
    );
  }
  print('-' * 37);

  final ip = hitungIp(data);
  print('Total SKS : ${data.fold<int>(0, (s, m) => s + m.sks)}');
  print('IP        : ${ip.toStringAsFixed(2)} (${predikat(ip)})');

  final perbaiki = data.where((m) => bobot(m.huruf) < 2).map((m) => m.nama);
  if (perbaiki.isNotEmpty) {
    print('Perlu diperbaiki: ${perbaiki.join(', ')}');
  }
}

void main() {
  final data = <Matkul>[];
  print('Masukkan data mata kuliah. Kosongkan nama untuk selesai.');

  while (true) {
    final nama = baca('Nama MK');
    if (nama.isEmpty) break;
    try {
      final sks = validasiSks(baca('SKS    '));
      final huruf = validasiNilai(baca('Nilai  '));
      data.add((nama: nama, sks: sks, huruf: huruf));
    } on FormatException catch (e) {
      print('Data diabaikan: ${e.message}');
    }
  }

  if (data.isEmpty) {
    print('Tidak ada data.');
    return;
  }
  cetakKhs(data, urutkan: true);
}
