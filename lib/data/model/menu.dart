import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';

List<MenuItem> items = [
  new MenuItem<int>(
    id: 0,
    title: 'Dashboard',
  ),
  new MenuItem<int>(
    id: 1,
    title: 'My Profile',
  ),
  new MenuItem<int>(
    id: 2,
    title: 'Settings',
  ),
  new MenuItem<int>(
    id: 3,
    title: 'My Availability',
  ),
  new MenuItem<int>(
    id: 4,
    title: 'My Store',
  ),
  new MenuItem<int>(
    id: 5,
    title: 'My Orders',
  ),
  new MenuItem<int>(
    id: 6,
    title: 'About us',
  ),
  new MenuItem<int>(
    id: 7,
    title: 'Terms of use',
  ),
  new MenuItem<int>(
    id: 8,
    title: 'Contact us',
  ),
  new MenuItem<int>(
    id: 9,
    title: 'Log out',
  ),
];
final menu = Menu(
  items: items.map((e) => e.copyWith(icon: null)).toList(),
);

final menuWithIcon = Menu(
  items: items,
);