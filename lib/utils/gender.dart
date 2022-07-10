import 'package:flutter/material.dart';

enum Gender {
  male, female
}

extension GenderExtensions on Gender {
  IconData get icon {
    switch(this){
      case Gender.male:
        return Icons.man;
      case Gender.female:
        return Icons.woman;
    }
  }
}