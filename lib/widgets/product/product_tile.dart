import 'package:biz_link/screens/auth/login_page.dart';
import 'package:biz_link/widgets/custom_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/auth_methods.dart';
import '../../functions/time_date_function.dart';
import '../../functions/unique_id_functions.dart';
import '../../models/app_user.dart';
import '../../models/chat/chat.dart';
import '../../models/product/product.dart';
import '../../providers/user_provider.dart';
import '../../screens/chat/personal_chat_page/product_chat_screen.dart';
import '../../utility/utilities.dart';
import '../custom_widgets/custom_profile_image.dart';
import 'prod_urls_slider.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({required this.product, Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute<ProductDetailScreen>(
        //   builder: (BuildContext context) =>
        //       ProductDetailScreen(product: product),
        // ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Header(product: product),
          AspectRatio(
            aspectRatio: Utilities.imageAspectRatio,
            child: ProductURLsSlider(urls: product.prodURL),
          ),
          _InfoCard(product: product),
          CustomElevatedButton(
            title: 'Message',
            onTap: () {
              if (AuthMethods.getCurrentUser == null) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
                return;
              }
              if (AuthMethods.uid == product.uid) return;
              final AppUser user =
                  Provider.of<UserProvider>(context, listen: false)
                      .user(uid: product.uid);
              Navigator.of(context).push(MaterialPageRoute<ProductChatScreen>(
                builder: (BuildContext context) => ProductChatScreen(
                  chatWith: user,
                  chat: Chat(
                    chatID: UniqueIdFunctions.productID(product.pid),
                    persons: <String>[
                      AuthMethods.uid,
                      product.uid,
                    ],
                    pid: product.pid,
                    prodIsVideo: product.prodURL[0].isVideo,
                  ),
                  product: product,
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.product, Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1),
            offset: const Offset(0, 0),
            blurRadius: 1,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                product.price.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.product, Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Consumer<UserProvider>(builder: (
        BuildContext context,
        UserProvider userPro,
        _,
      ) {
        final AppUser user = userPro.user(uid: product.uid);
        return GestureDetector(
          onTap: () {
            // user.uid == AuthMethods.uid
            //     ? Provider.of<AppProvider>(context, listen: false)
            //         .onTabTapped(4)
            //     : Navigator.of(context).push(
            //         MaterialPageRoute<OthersProfile>(
            //           builder: (BuildContext context) =>
            //               OthersProfile(user: user),
            //         ),
            //       );
          },
          child: Row(
            children: <Widget>[
              CustomProfileImage(imageURL: user.imageURL ?? ''),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.displayName ?? 'Not Found',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    TimeDateFunctions.timeInWords(product.timestamp ?? 0),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.adaptive.more),
              )
            ],
          ),
        );
      }),
    );
  }
}
