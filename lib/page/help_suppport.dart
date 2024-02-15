import 'package:e_form/config/app_color.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundScaffold,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Privacy & Policy',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextMain(
                  text: 'Help & Support',
                  textFontWeight: FontWeight.bold,
                  size: 18,
                ),
                SizedBox(
                  height: 20,
                ),
                TextMain(text: '''
Selamat datang di Layanan Bantuan & Dukungan untuk Aplikasi e-form kami!

Kami sangat menghargai kepercayaan dan kesetiaan Anda dalam menggunakan aplikasi e-form kami. Kami memahami bahwa kadang-kadang Anda mungkin membutuhkan bantuan atau informasi tambahan tentang cara menggunakan aplikasi ini secara efektif. Oleh karena itu, kami telah menyediakan tim dukungan yang ramah dan berpengetahuan luas untuk membantu menjawab semua pertanyaan Anda.

Apakah Anda mengalami kesulitan dalam pengisian formulir? Atau mungkin Anda ingin mengetahui lebih lanjut tentang fitur-fitur terbaru yang telah kami tambahkan? Tak perlu khawatir! Kami siap membantu Anda dengan setiap langkahnya.

Jangan ragu untuk menghubungi kami melalui salah satu dari opsi berikut ini:

Nomor telepon kami: 0000-0000-0000
Email kami: 0000@gmail.com

Tim dukungan kami berada di sini untuk memastikan bahwa pengalaman Anda menggunakan aplikasi e-form kami menjadi sebaik mungkin. Kami menghargai setiap umpan balik dari Anda, karena itu membantu kami terus meningkatkan layanan kami.

Terima kasih telah memilih aplikasi e-form kami untuk memenuhi kebutuhan Anda. Kami berharap Anda merasa puas dengan pengalaman menggunakan aplikasi kami, dan kami siap membantu Anda dalam perjalanan ini.

Salam hangat,
[Tim Dukungan Aplikasi e-form]
'''),
              ],
            )),
      ),
    );
  }
}
