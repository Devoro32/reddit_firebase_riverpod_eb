//constants
export 'package:reddit_fb_rp/core/constants/constants.dart';
export 'package:reddit_fb_rp/core/constants/firebase_constants.dart';

//common
export 'package:reddit_fb_rp/core/common/sign_in_button.dart';
export 'package:reddit_fb_rp/core/common/loader.dart';
export 'package:reddit_fb_rp/core/common/error_text.dart';

//community

//controller
export 'package:reddit_fb_rp/features/auth/controller/auth_controller.dart';
export 'package:reddit_fb_rp/features/community/controller/community_controller.dart';
export 'package:reddit_fb_rp/features/user_profile/controller/user_profile_controller.dart';

//delegate
export 'package:reddit_fb_rp/features/home/delegates/search_community_delegate.dart';

//drawers
export 'package:reddit_fb_rp/features/home/drawers/community_list_drawers.dart';
export 'package:reddit_fb_rp/features/home/drawers/profile_drawer.dart';

//features
export 'package:reddit_fb_rp/features/home/screens/home_screen.dart';

//packages

export 'package:flutter/material.dart';
export 'package:hooks_riverpod/hooks_riverpod.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_storage/firebase_storage.dart';
export 'package:reddit_fb_rp/firebase_options.dart';
export 'package:reddit_fb_rp/core/type_defs.dart';
export 'package:reddit_fb_rp/core/failure.dart';
export 'package:reddit_fb_rp/core/utilis.dart';
export 'package:routemaster/routemaster.dart';
export 'package:dotted_border/dotted_border.dart';
export 'package:file_picker/file_picker.dart';
export 'dart:io';

//model
export 'package:reddit_fb_rp/models/user_model.dart';
export 'package:reddit_fb_rp/models/communities_model.dart';
//providers
export 'package:reddit_fb_rp/core/provider/firebase_provider.dart';

//Repository
export 'package:reddit_fb_rp/features/auth/repository/auth_repository.dart';
export 'package:reddit_fb_rp/core/provider/storage_repository_provider.dart';
export 'package:reddit_fb_rp/features/community/repository/community_repository.dart';
export 'package:reddit_fb_rp/features/user_profile/repository/user_profile_repository.dart';

//route
export 'package:reddit_fb_rp/routes.dart';

//screens
export 'package:reddit_fb_rp/features/auth/screens/login_screen.dart';
export 'package:reddit_fb_rp/features/community/screens/community_screen.dart';
export 'package:reddit_fb_rp/features/community/screens/create_community_screen.dart';
export 'package:reddit_fb_rp/features/community/screens/mod_tools_screen.dart';
export 'package:reddit_fb_rp/features/community/screens/edit_community_screen.dart';
export 'package:reddit_fb_rp/features/user_profile/screens/user_profile_screen.dart';
export 'package:reddit_fb_rp/features/user_profile/screens/edit_profile_screen.dart';

//theme
export 'package:reddit_fb_rp/theme/pallete.dart';
