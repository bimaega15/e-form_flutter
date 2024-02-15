// ignore_for_file: must_be_immutable, avoid_print

import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/widget/data_transaksi.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';

class DetailTransaksi extends StatelessWidget {
  DetailTransaksi({
    super.key,
    required this.receivedData,
  });

  Map<dynamic, dynamic> receivedData;

  void onDownload(Map<dynamic, dynamic> receivedData) async {
    print('value');
  }

  @override
  Widget build(BuildContext context) {
    int isPpn = receivedData['ppn'];
    String attachment = receivedData['attachment'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataTransaksi(
            titleLeft: 'Metode Pembayaran',
            answerRight: receivedData['paymentMethod'],
            answerRight3: receivedData['purposeTransaction'],
          ),
          const Divider(
            color: AppColor.borderColor,
            thickness: 0.2,
          ),
          DataTransaksi(
            titleLeft: 'Waktu Transaksi',
            answerLeft: Utils().formatDateIndo(receivedData['reqDate']),
            titleRight: 'ID Transaksi',
            answerRight: receivedData['noReq'],
          ),
          const Divider(
            color: AppColor.borderColor,
            thickness: 0.2,
          ),
          DataTransaksi(
            titleLeft: 'Nama Mengajukan',
            answerLeft: receivedData['reqBy'],
            titleRight: 'Jabatan',
            answerRight: receivedData['position'],
          ),
          const Divider(
            color: AppColor.borderColor,
            thickness: 0.2,
          ),
          DataTransaksi(
            titleLeft: 'Divisi',
            answerLeft: receivedData['unitName'],
            titleRight: 'Kategori Office',
            answerRight: receivedData['categoryOffice'],
          ),
          const Divider(
            color: AppColor.borderColor,
            thickness: 0.2,
          ),
          DataTransaksi(
            titleLeft: 'Alamat',
            answerLeft: receivedData['address'],
            titleRight: 'Tujuan Divisi',
            answerRight: receivedData['purposeDivisi'],
          ),
          const Divider(
            color: AppColor.borderColor,
            thickness: 0.2,
          ),
          DataTransaksi(
            titleLeft: 'PPN',
            answerLeftIcon: isPpn == 1 ? Icons.check : Icons.cancel,
            titleRight: isPpn == 1 ? 'Nilai PPN' : '',
            answerRight: isPpn == 1 ? receivedData['amountPpn'].toString() : '',
          ),
          const Divider(
            color: AppColor.borderColor,
            thickness: 0.2,
          ),
          DataTransaksi(
            titleLeft: 'Payment Term',
            answerLeft: '${receivedData['paymentTerms']} Hari',
            titleRight: 'Tanggal Expired',
            answerRight: Utils().formatDateIndo(receivedData['expDate']),
          ),
          const Divider(
            color: AppColor.borderColor,
            thickness: 0.2,
          ),
          Visibility(
            visible: receivedData['paymentMethod'] == 'Transfer',
            child: const DataTransaksi(
              titleLeft: 'Bank Penerima',
              answerLeft: 'BANK BNI',
            ),
          ),
          if (attachment != '' && attachment.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextMain(
                  textAlign: TextAlign.left,
                  text: 'File Pengajuan',
                  textColor: AppColor.greyColor,
                  size: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          onDownload(receivedData);
                        },
                        icon: const Icon(Icons.download)),
                    const SizedBox(
                      width: 10,
                    ),
                    const TextMain(
                      text: 'Download File',
                      size: 14,
                      textFontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const Divider(
                  color: AppColor.borderColor,
                  thickness: 0.2,
                ),
              ],
            )
        ],
      ),
    );
  }
}
