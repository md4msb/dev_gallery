import 'package:flutter/material.dart';

extension PaddingExtensions on Widget {
  Widget p(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);
  Widget px(double value) => Padding(
    padding: EdgeInsets.symmetric(horizontal: value),
    child: this,
  );
  Widget py(double value) => Padding(
    padding: EdgeInsets.symmetric(vertical: value),
    child: this,
  );
  Widget pt(double value) => Padding(
    padding: EdgeInsets.only(top: value),
    child: this,
  );
  Widget pb(double value) => Padding(
    padding: EdgeInsets.only(bottom: value),
    child: this,
  );
  Widget pl(double value) => Padding(
    padding: EdgeInsets.only(left: value),
    child: this,
  );
  Widget pr(double value) => Padding(
    padding: EdgeInsets.only(right: value),
    child: this,
  );
}
