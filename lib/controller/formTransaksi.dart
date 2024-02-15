// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:io';
import 'package:dio/dio.dart';

class FormTransaksi {
  final String code_transaction;
  final String tanggal_transaction;
  final String paidto_transaction;
  final int metode_pembayaran_id;
  final String expired_transaction;
  final String purpose_transaction;
  final String purposedivisi_transaction;
  final int isppn_transaction;
  final num valueppn_transaction;
  final File? attachment_transaction;
  final String? products_id;
  final String? qty_detail;
  final String? price_detail;
  final String? subtotal_detail;
  final String? remarks_detail;
  final String? matauang_detail;
  final String? kurs_detail;
  final int paymentterms_transaction;
  final int totalproduct_transaction;
  final num totalprice_transaction;
  final int overbooking_transaction;
  final String? jenis_over_booking;
  final String? darirekening_booking;
  final String? pemilikrekening_booking;
  final String? tujuanrekening_booking;
  final String? pemiliktujuan_booking;
  final String? nominal_booking;
  final String? nomorvirtual_transaction;
  final String? accept_transaction;
  final String? bank_transaction;
  final num? totalppn_transaction;
  final num? subtotal_transaction;

  FormTransaksi({
    required this.code_transaction,
    required this.tanggal_transaction,
    required this.paidto_transaction,
    required this.metode_pembayaran_id,
    required this.expired_transaction,
    required this.purpose_transaction,
    required this.purposedivisi_transaction,
    required this.isppn_transaction,
    required this.valueppn_transaction,
    this.attachment_transaction,
    this.products_id,
    this.qty_detail,
    this.price_detail,
    this.subtotal_detail,
    this.remarks_detail,
    required this.paymentterms_transaction,
    required this.totalproduct_transaction,
    required this.totalprice_transaction,
    required this.overbooking_transaction,
    this.jenis_over_booking,
    this.darirekening_booking,
    this.pemilikrekening_booking,
    this.tujuanrekening_booking,
    this.pemiliktujuan_booking,
    this.nominal_booking,
    this.nomorvirtual_transaction,
    this.accept_transaction,
    this.bank_transaction,
    this.totalppn_transaction,
    this.subtotal_transaction,
    this.matauang_detail,
    this.kurs_detail,
  });

  factory FormTransaksi.fromJson(Map<String, dynamic> json) {
    return FormTransaksi(
      code_transaction: json['code_transaction'],
      tanggal_transaction: (json['tanggal_transaction']),
      paidto_transaction: json['paidto_transaction'],
      metode_pembayaran_id: json['metode_pembayaran_id'],
      expired_transaction: (json['expired_transaction']),
      purpose_transaction: json['purpose_transaction'],
      purposedivisi_transaction: json['purposedivisi_transaction'],
      isppn_transaction: json['isppn_transaction'],
      valueppn_transaction: json['valueppn_transaction'].toDouble(),
      products_id: json['products_id'],
      qty_detail: json['qty_detail'],
      price_detail: json['price_detail'],
      subtotal_detail: json['subtotal_detail'],
      remarks_detail: json['remarks_detail'],
      paymentterms_transaction: json['paymentterms_transaction'],
      totalproduct_transaction: json['totalproduct_transaction'],
      totalprice_transaction: json['totalprice_transaction'],
      overbooking_transaction: json['overbooking_transaction'],
      jenis_over_booking: json['jenis_over_booking'],
      darirekening_booking: json['darirekening_booking'],
      pemilikrekening_booking: json['pemilikrekening_booking'],
      tujuanrekening_booking: json['tujuanrekening_booking'],
      pemiliktujuan_booking: json['pemiliktujuan_booking'],
      nominal_booking: json['nominal_booking'],
      attachment_transaction: json['attachment_transaction'] != null
          ? File(json['attachment_transaction'])
          : null,
      nomorvirtual_transaction: json['nomorvirtual_transaction'],
      accept_transaction: json['accept_transaction'],
      bank_transaction: json['bank_transaction'],
      totalppn_transaction: json['totalppn_transaction'],
      subtotal_transaction: json['subtotal_transaction'],
      matauang_detail: json['matauang_detail'],
      kurs_detail: json['kurs_detail'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'code_transaction': code_transaction,
      'tanggal_transaction': tanggal_transaction,
      'paidto_transaction': paidto_transaction,
      'metode_pembayaran_id': metode_pembayaran_id,
      'expired_transaction': expired_transaction,
      'purpose_transaction': purpose_transaction,
      'purposedivisi_transaction': purposedivisi_transaction,
      'isppn_transaction': isppn_transaction,
      'valueppn_transaction': valueppn_transaction,
      'paymentterms_transaction': paymentterms_transaction,
      'totalproduct_transaction': totalproduct_transaction,
      'totalprice_transaction': totalprice_transaction,
      'overbooking_transaction': overbooking_transaction,
      'products_id': products_id,
      'qty_detail': qty_detail,
      'price_detail': price_detail,
      'subtotal_detail': subtotal_detail,
      'remarks_detail': remarks_detail,
      'attachment_transaction': attachment_transaction,
    };

    if (jenis_over_booking != null) {
      data['jenis_over_booking'] = jenis_over_booking!;
    }
    if (darirekening_booking != null) {
      data['darirekening_booking'] = darirekening_booking!;
    }
    if (pemilikrekening_booking != null) {
      data['pemilikrekening_booking'] = pemilikrekening_booking!;
    }
    if (tujuanrekening_booking != null) {
      data['tujuanrekening_booking'] = tujuanrekening_booking!;
    }
    if (pemiliktujuan_booking != null) {
      data['pemiliktujuan_booking'] = pemiliktujuan_booking!;
    }
    if (nominal_booking != null) {
      data['nominal_booking'] = nominal_booking!;
    }
    if (attachment_transaction != null) {
      data['attachment_transaction'] = attachment_transaction!.path;
    }
    if (nomorvirtual_transaction != null) {
      data['nomorvirtual_transaction'] = nomorvirtual_transaction;
    }
    if (accept_transaction != null) {
      data['accept_transaction'] = accept_transaction;
    }
    if (bank_transaction != null) {
      data['bank_transaction'] = bank_transaction;
    }
    if (totalppn_transaction != null) {
      data['totalppn_transaction'] = totalppn_transaction;
    }
    if (subtotal_transaction != null) {
      data['subtotal_transaction'] = subtotal_transaction;
    }
    if (matauang_detail != null) {
      data['matauang_detail'] = matauang_detail;
    }
    if (kurs_detail != null) {
      data['kurs_detail'] = kurs_detail;
    }

    return data;
  }

  FormData convertoFormData() {
    FormData formData = FormData();

    formData.fields.addAll([
      MapEntry('code_transaction', code_transaction),
      MapEntry('tanggal_transaction', tanggal_transaction),
      MapEntry('paidto_transaction', paidto_transaction),
      MapEntry('metode_pembayaran_id', metode_pembayaran_id.toString()),
      MapEntry('expired_transaction', expired_transaction),
      MapEntry('purpose_transaction', purpose_transaction),
      MapEntry('purposedivisi_transaction', purposedivisi_transaction),
      MapEntry('isppn_transaction', isppn_transaction.toString()),
      MapEntry('valueppn_transaction', valueppn_transaction.toString()),
      MapEntry('paymentterms_transaction', paymentterms_transaction.toString()),
      MapEntry('totalproduct_transaction', totalproduct_transaction.toString()),
      MapEntry('totalprice_transaction', totalprice_transaction.toString()),
      MapEntry('overbooking_transaction', overbooking_transaction.toString()),
      MapEntry('products_id', products_id.toString()),
      MapEntry('qty_detail', qty_detail.toString()),
      MapEntry('price_detail', price_detail.toString()),
      MapEntry('subtotal_detail', subtotal_detail.toString()),
      MapEntry('remarks_detail', remarks_detail.toString()),
    ]);

    if (jenis_over_booking != null) {
      formData.fields.add(MapEntry('jenis_over_booking', jenis_over_booking!));
    }
    if (darirekening_booking != null) {
      formData.fields
          .add(MapEntry('darirekening_booking', darirekening_booking!));
    }
    if (pemilikrekening_booking != null) {
      formData.fields
          .add(MapEntry('pemilikrekening_booking', pemilikrekening_booking!));
    }
    if (tujuanrekening_booking != null) {
      formData.fields
          .add(MapEntry('tujuanrekening_booking', tujuanrekening_booking!));
    }
    if (pemiliktujuan_booking != null) {
      formData.fields
          .add(MapEntry('pemiliktujuan_booking', pemiliktujuan_booking!));
    }
    if (nominal_booking != null) {
      formData.fields.add(MapEntry('nominal_booking', nominal_booking!));
    }

    if (attachment_transaction!.path != '' &&
        attachment_transaction!.path.isNotEmpty) {
      formData.files.add(MapEntry(
          'attachment_transaction',
          MultipartFile.fromFileSync(attachment_transaction!.path,
              filename: attachment_transaction!.path.split('/').last)));
    }
    if (nomorvirtual_transaction != null) {
      formData.fields
          .add(MapEntry('nomorvirtual_transaction', nomorvirtual_transaction!));
    }
    if (accept_transaction != null) {
      formData.fields.add(MapEntry('accept_transaction', accept_transaction!));
    }
    if (bank_transaction != null) {
      formData.fields.add(MapEntry('bank_transaction', bank_transaction!));
    }
    if (totalppn_transaction != null) {
      formData.fields.add(
          MapEntry('totalppn_transaction', totalppn_transaction.toString()));
    }
    if (subtotal_transaction != null) {
      formData.fields.add(
          MapEntry('subtotal_transaction', subtotal_transaction.toString()));
    }
    if (matauang_detail != null) {
      formData.fields.add(MapEntry('matauang_detail', matauang_detail!));
    }
    if (kurs_detail != null) {
      formData.fields.add(MapEntry('kurs_detail', kurs_detail!));
    }

    return formData;
  }
}
