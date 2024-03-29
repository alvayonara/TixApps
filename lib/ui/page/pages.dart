import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tix_apps/bloc/blocs.dart';
import 'package:tix_apps/main.dart';
import 'package:tix_apps/model/models.dart';
import 'package:tix_apps/service/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tix_apps/shared/shared.dart';
import 'package:tix_apps/ui/widget/widgets.dart';

part 'sign_in_page.dart';
part 'wrapper.dart';
part 'main_page.dart';
part 'splash_page.dart';
part 'movie_page.dart';
part 'sign_up_page.dart';
part 'preferences_page.dart';
part 'account_confirmation_page.dart';

// Function to get Image (page: registration, edit data)
Future<File> getImage() async {
  final _picker = ImagePicker();
  final image = await _picker.getImage(source: ImageSource.gallery);

  return File(image.path);
}
