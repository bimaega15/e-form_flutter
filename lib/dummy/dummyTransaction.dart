// ignore_for_file: file_names

import 'package:e_form/config/app_asset.dart';
import 'package:flutter/material.dart';

class DummyTransaction {
  String avatar;
  String name;
  String date;
  String status;
  String purpose;
  String codeTransaction;
  List<Image> avatarImages;

  DummyTransaction({
    required this.avatar,
    required this.name,
    required this.date,
    required this.status,
    required this.purpose,
    required this.codeTransaction,
    required this.avatarImages,
  });
}

List<DummyTransaction> dummyTransaction = [
  DummyTransaction(
    avatar: AppAsset.person_1,
    name: 'John Doe',
    date: '20 Januari 2024',
    status: 'menunggu',
    purpose: 'Beli Perlengkapan',
    codeTransaction: 'TRX013481983',
    avatarImages: [
      Image.asset(AppAsset.person_1),
      Image.asset(AppAsset.person_2),
      Image.asset(AppAsset.person_3),
      Image.asset(AppAsset.person_4),
      Image.asset(AppAsset.person_5),
      Image.asset(AppAsset.person_6)
    ],
  ),
  DummyTransaction(
      avatar: AppAsset.person_2,
      name: 'Ridwan Sip',
      date: '01 Januari 2024',
      status: 'setuju',
      purpose: 'Beli Alat Kantor',
      codeTransaction: 'TRX013481984',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_3,
      name: 'Asam Sulfat',
      date: '03 Januari 2024',
      status: 'ditolak',
      purpose: 'Alat Tulis',
      codeTransaction: 'TRX013481984',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_4,
      name: 'Jiwamu Baik',
      date: '10 Januari 2024',
      status: 'setuju',
      purpose: 'Beli Alat',
      codeTransaction: 'TRX013481985',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_5,
      name: 'Simpati As',
      date: '15 Januari 2024',
      status: 'direvisi',
      purpose: 'Beli Alat Perang',
      codeTransaction: 'TRX013481986',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_6,
      name: 'Simpanse Bos',
      date: '17 Januari 2024',
      status: 'menunggu',
      purpose: 'Perlengkapan Kantor',
      codeTransaction: 'TRX013481987',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_7,
      name: 'KPK Family',
      date: '19 Januari 2024',
      status: 'setuju',
      purpose: 'Beli Transportasi',
      codeTransaction: 'TRX013481988',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_8,
      name: 'Joe Bidden',
      date: '03 Januari 2024',
      status: 'menunggu',
      purpose: 'Beli Buku Tulis',
      codeTransaction: 'TRX013481989',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_9,
      name: 'Jack Ma',
      date: '09 Januari 2024',
      status: 'ditolak',
      purpose: 'Beli Pena',
      codeTransaction: 'TRX0138913821',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_10,
      name: 'Main Master',
      date: '10 Januari 2024',
      status: 'menunggu',
      purpose: 'Beli Asam Sulfat',
      codeTransaction: 'TRX01319301341',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_11,
      name: 'Hello Bos',
      date: '12 Januari 2024',
      status: 'ditolak',
      purpose: 'Beli Plastik',
      codeTransaction: 'TRX01319301342',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  // Add more items as needed
];

List<DummyTransaction> dummyMenunggu = [
  DummyTransaction(
    avatar: AppAsset.person_1,
    name: 'John Doe',
    date: '20 Januari 2024',
    status: 'menunggu',
    purpose: 'Beli Perlengkapan',
    codeTransaction: 'TRX013481983',
    avatarImages: [
      Image.asset(AppAsset.person_1),
      Image.asset(AppAsset.person_2),
      Image.asset(AppAsset.person_3),
      Image.asset(AppAsset.person_4),
      Image.asset(AppAsset.person_5),
      Image.asset(AppAsset.person_6)
    ],
  ),
  DummyTransaction(
      avatar: AppAsset.person_2,
      name: 'Ridwan Sip',
      date: '01 Januari 2024',
      status: 'setuju',
      purpose: 'Beli Alat Kantor',
      codeTransaction: 'TRX013481984',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_3,
      name: 'Asam Sulfat',
      date: '03 Januari 2024',
      status: 'ditolak',
      purpose: 'Alat Tulis',
      codeTransaction: 'TRX013481984',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_4,
      name: 'Jiwamu Baik',
      date: '10 Januari 2024',
      status: 'setuju',
      purpose: 'Beli Alat',
      codeTransaction: 'TRX013481985',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  // Add more items as needed
];

List<DummyTransaction> dummyDisetujui = [
  DummyTransaction(
      avatar: AppAsset.person_6,
      name: 'Simpanse Bos',
      date: '17 Januari 2024',
      status: 'menunggu',
      purpose: 'Perlengkapan Kantor',
      codeTransaction: 'TRX013481987',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_7,
      name: 'KPK Family',
      date: '19 Januari 2024',
      status: 'setuju',
      purpose: 'Beli Transportasi',
      codeTransaction: 'TRX013481988',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_8,
      name: 'Joe Bidden',
      date: '03 Januari 2024',
      status: 'menunggu',
      purpose: 'Beli Buku Tulis',
      codeTransaction: 'TRX013481989',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_9,
      name: 'Jack Ma',
      date: '09 Januari 2024',
      status: 'ditolak',
      purpose: 'Beli Pena',
      codeTransaction: 'TRX0138913821',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_10,
      name: 'Main Master',
      date: '10 Januari 2024',
      status: 'menunggu',
      purpose: 'Beli Asam Sulfat',
      codeTransaction: 'TRX01319301341',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_11,
      name: 'Hello Bos',
      date: '12 Januari 2024',
      status: 'ditolak',
      purpose: 'Beli Plastik',
      codeTransaction: 'TRX01319301342',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  // Add more items as needed
];

List<DummyTransaction> dummyDitolak = [
  DummyTransaction(
      avatar: AppAsset.person_2,
      name: 'Ridwan Sip',
      date: '01 Januari 2024',
      status: 'setuju',
      purpose: 'Beli Alat Kantor',
      codeTransaction: 'TRX013481984',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_3,
      name: 'Asam Sulfat',
      date: '03 Januari 2024',
      status: 'ditolak',
      purpose: 'Alat Tulis',
      codeTransaction: 'TRX013481984',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_4,
      name: 'Jiwamu Baik',
      date: '10 Januari 2024',
      status: 'setuju',
      purpose: 'Beli Alat',
      codeTransaction: 'TRX013481985',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_5,
      name: 'Simpati As',
      date: '15 Januari 2024',
      status: 'direvisi',
      purpose: 'Beli Alat Perang',
      codeTransaction: 'TRX013481986',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_6,
      name: 'Simpanse Bos',
      date: '17 Januari 2024',
      status: 'menunggu',
      purpose: 'Perlengkapan Kantor',
      codeTransaction: 'TRX013481987',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_7,
      name: 'KPK Family',
      date: '19 Januari 2024',
      status: 'setuju',
      purpose: 'Beli Transportasi',
      codeTransaction: 'TRX013481988',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_8,
      name: 'Joe Bidden',
      date: '03 Januari 2024',
      status: 'menunggu',
      purpose: 'Beli Buku Tulis',
      codeTransaction: 'TRX013481989',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),

  // Add more items as needed
];

List<DummyTransaction> dummyDirevisi = [
  DummyTransaction(
    avatar: AppAsset.person_1,
    name: 'John Doe',
    date: '20 Januari 2024',
    status: 'menunggu',
    purpose: 'Beli Perlengkapan',
    codeTransaction: 'TRX013481983',
    avatarImages: [
      Image.asset(AppAsset.person_1),
      Image.asset(AppAsset.person_2),
      Image.asset(AppAsset.person_3),
      Image.asset(AppAsset.person_4),
      Image.asset(AppAsset.person_5),
      Image.asset(AppAsset.person_6)
    ],
  ),
  DummyTransaction(
      avatar: AppAsset.person_2,
      name: 'Ridwan Sip',
      date: '01 Januari 2024',
      status: 'setuju',
      purpose: 'Beli Alat Kantor',
      codeTransaction: 'TRX013481984',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_7,
      name: 'KPK Family',
      date: '19 Januari 2024',
      status: 'setuju',
      purpose: 'Beli Transportasi',
      codeTransaction: 'TRX013481988',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  DummyTransaction(
      avatar: AppAsset.person_8,
      name: 'Joe Bidden',
      date: '03 Januari 2024',
      status: 'menunggu',
      purpose: 'Beli Buku Tulis',
      codeTransaction: 'TRX013481989',
      avatarImages: [
        Image.asset(AppAsset.person_1),
        Image.asset(AppAsset.person_2),
        Image.asset(AppAsset.person_3),
        Image.asset(AppAsset.person_4),
        Image.asset(AppAsset.person_5),
        Image.asset(AppAsset.person_6)
      ]),
  // Add more items as needed
];

final List<String> metodeOverBooking = [
  'Rekening ke Rekening',
  'Rekening ke Tunai',
  'Tunai ke Rekening'
];
