import 'package:flutter/material.dart';
import 'package:pingolearn/core/theme/app_pallete.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsListtile extends StatelessWidget {
  final String newsSource;
  final String title;
  final String image;
  final String dateTime;
  final VoidCallback onTap;
  const NewsListtile(
      {required this.newsSource,
      required this.title,
      required this.image,
      required this.dateTime,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppPallete.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsSource,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 17),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        " ${getTimeAgo(dateTime)} ago",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                      color: AppPallete.greyColor,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getTimeAgo(String dateTime) {
    final parsedDate = DateTime.parse(dateTime);
    final now = DateTime.now();
    final difference = now.difference(parsedDate);
    return timeago.format(now.subtract(difference), locale: 'en_short');
  }
}
