import 'package:flutter/material.dart';
import 'package:medapp/config/app_config.dart';
import 'package:medapp/providers/firebase_providers.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:medapp/providers/shared_providers.dart';

List<SingleChildWidget> buildProviders(AppConfig config) {
  return [...sharedProviders, ...firebaseProviders];
}
