import 'package:flutter/material.dart';
import 'package:motion_apps/models/kit.dart';

class KitCard extends StatelessWidget {
  final Kit kit;

  const KitCard({super.key, required this.kit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 GAMBAR FULL BLEED — 100% COVER CONTAINER
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 120,        // Tambah tinggi → gambar makin gede
              width: double.infinity,
              child: Image.asset(
                kit.image,
                fit: BoxFit.cover, // Cover = full tanpa sisa
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Starter Kit",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            kit.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              Text(
                kit.price,
                style: const TextStyle(
                  color: Colors.teal,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 6),

              Flexible(
                child: Text(
                  kit.oldPrice,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
