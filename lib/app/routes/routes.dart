import 'package:flutter/widgets.dart';
import 'package:super_gallery_v2/app/cubit/app_cubit.dart';
import 'package:super_gallery_v2/login/login.dart';
import 'package:super_gallery_v2/upload/upload.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [UploadPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
