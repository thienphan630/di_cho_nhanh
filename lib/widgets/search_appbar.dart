import 'package:flutter/material.dart';

PreferredSizeWidget appBarSearch() {
  return AppBar(
    primary: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 44,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: Colors.grey,
              size: 32,
            ),
          ),
          Expanded(
            child: TextFormField(
                style: const TextStyle(
                  fontSize: 20,
                  decorationThickness: 0,
                ),
                decoration: const InputDecoration.collapsed(
                    border: InputBorder.none,
                    hintText: 'Tìm kiếm',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ))),
          ),
        ],
      ),
    ),
    leading: Padding(
      padding: const EdgeInsets.only(top: 4, left: 4),
      child: Image.asset(
        'assets/images/cat.jpg',
        fit: BoxFit.cover,
      ),
    ),
  );
}
