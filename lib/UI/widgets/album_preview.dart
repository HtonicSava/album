import 'package:flutter/material.dart';

class AlbumPreview extends StatelessWidget {
  final String albumCoverLink;
  final String albumName;
  final int albumPagesNumber;

  const AlbumPreview(
      {required this.albumName,
      required this.albumPagesNumber,
      required this.albumCoverLink});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),

      child: SizedBox(

        // width: 231,
        // height: 380,
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      albumName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.more_horiz,
                      size: 36.0,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 4.0),
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                    color: Colors.grey, shape: BoxShape.circle),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                    color: Colors.grey, shape: BoxShape.circle),
                              ),
                            ],
                          ),
                          Text(
                            '${albumPagesNumber} ??????.',
                            style: const TextStyle(
                                fontSize: 16, color: Color(0xFFA5A5A5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(albumCoverLink),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
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
