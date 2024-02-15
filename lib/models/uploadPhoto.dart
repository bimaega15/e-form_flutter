// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:io';
import 'package:dio/dio.dart';

class UploadPhoto {
  final File? gambar_profile;

  UploadPhoto({
    this.gambar_profile,
  });

  factory UploadPhoto.fromJson(Map<String, dynamic> json) {
    return UploadPhoto(
      gambar_profile:
          json['gambar_profile'] != null ? File(json['gambar_profile']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'gambar_profile': gambar_profile,
    };

    if (gambar_profile != null) {
      data['gambar_profile'] = gambar_profile!.path;
    }

    return data;
  }

  FormData convertoFormData() {
    FormData formData = FormData();

    if (gambar_profile!.path != '' && gambar_profile!.path.isNotEmpty) {
      formData.files.add(MapEntry(
          'gambar_profile',
          MultipartFile.fromFileSync(gambar_profile!.path,
              filename: gambar_profile!.path.split('/').last)));
    }

    return formData;
  }
}
