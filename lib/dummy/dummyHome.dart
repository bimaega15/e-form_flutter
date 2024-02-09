import 'package:e_form/config/app_asset.dart';

class DummyHome {
  String name;
  String icon;
  String count;

  DummyHome({required this.name, required this.icon, required this.count});
}

List<DummyHome> dummyList = [
  DummyHome(name: 'Menunggu', icon: AppAsset.card_title_1, count: '10'),
  DummyHome(name: 'Disetujui', icon: AppAsset.card_title_2, count: '5'),
  DummyHome(name: 'Ditolak', icon: AppAsset.card_title_3, count: '8'),
  DummyHome(name: 'Accesor Setuju', icon: AppAsset.card_title_4, count: '12'),
  DummyHome(name: 'Accesor Ditolak', icon: AppAsset.card_title_5, count: '19'),
  DummyHome(name: 'Accesor Revisi', icon: AppAsset.card_title_6, count: '25'),
  // Add more items as needed
];

final Map<String, String> mappingTransaksi = {
  'totalWaiting': 'Menunggu',
  'totalSuccess': 'Disetujui',
  'totalReject': 'Ditolak',
  'totalWaitingAccesor': 'Accesor Setuju',
  'totalSuccessAccesor': 'Accesor Ditolak',
  'totalRejectAccesor': 'Accesor Revisi',
};
