import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../common/const/colors.dart';
import '../../common/const/typography.dart';

class ChatItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String lastMessage;
  final VoidCallback onTap;
  final int count;

  const ChatItem({
    required this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.onTap,
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 390.w,
        height: 90.w,
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 55.w,
                  height: 55.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: base3,
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 55.w,
                      height: 55.w,
                      placeholder: (context, url) =>
                          Image.memory(kTransparentImage),
                      errorWidget: (context, url, error) => Container(
                        color: base3,
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: 40.w,
                          ),
                        ),
                      ),
                      fadeInDuration: const Duration(milliseconds: 100),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 17.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: headerText3,
                    ),
                    SizedBox(height: 5.w),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 210.w),
                      child: Text(
                        lastMessage,
                        style: headerText5.copyWith(color: gray700),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                  ],
                )
              ],
            ),
            count <= 0 ? const SizedBox.shrink() : Container(
              height: 30.w,
              width: 30.w,
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: main1,
              ),
              child: Center(
                child: Text(
                  '+$count',
                  style: headerText5.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
