import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViwer extends StatelessWidget {
  final List<String> image;

  const ImageViwer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: image.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: SizedBox(
              height: 300,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  image[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
