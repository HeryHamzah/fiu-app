import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fiu/bloc/blocs.dart';
import 'package:fiu/model/models.dart';
import 'package:fiu/services/services.dart';
import 'package:fiu/shared/shared.dart';
import 'package:fiu/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:random_string/random_string.dart';
import 'package:fiu/extensions/extensions.dart';
import 'package:path/path.dart';
import 'package:ticketview/ticketview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

part 'splash_page.dart';
part 'wrapper.dart';
part 'main_page.dart';
part 'sign_in_page.dart';
part 'sign_up_page.dart';
part 'preference_page.dart';
part 'account_confirmation_page.dart';
part 'movie_detail_page.dart';
part 'booking_page.dart';
part 'checkout_page.dart';
part 'top_up_page.dart';
part 'succes_page.dart';
part 'profile_page.dart';
part 'edit_profile_page.dart';
part 'my_wallet_page.dart';
part 'home_page.dart';
part 'my_tickets_page.dart';
part 'ticket_detail_page.dart';
part 'reset_password_page.dart';
part 'favorite_movies_page.dart';
