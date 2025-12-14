// lib/list_item_widget.dart

import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const ListItemWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Placeholder Gambar (kotak abu-abu di kiri)
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[400], 
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            const SizedBox(width: 15), 
            
            // Kolom Teks (Title dan Subtitle)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(subtitle, style: TextStyle(color: Colors.grey[600])),
                  // Placeholder untuk garis-garis pendek
                  Container(
                    width: 100,
                    height: 5,
                    margin: const EdgeInsets.only(top: 8),
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}