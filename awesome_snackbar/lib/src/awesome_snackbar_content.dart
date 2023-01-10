import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'assets_path.dart';
import 'content_type.dart';

class AwesomeSnackbarContent extends StatelessWidget {
  final String title;
  final String message;
  final Color? color;
  final ContentType contentType;
  final bool inMaterialBanner;

  const AwesomeSnackbarContent({
    Key? key,
    this.color,
    required this.title,
    required this.message,
    required this.contentType,
    this.inMaterialBanner = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // screen dimensions
    bool isMobile = size.width <= 768;
    bool isTablet = size.width > 768 && size.width <= 992;
    bool isDesktop = size.width >= 992;

    final hsl = HSLColor.fromColor(color ?? contentType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    return Row(
      children: [
        !isMobile
            ? const Spacer()
            : SizedBox(
                width: size.width * 0.01,
              ),
        Expanded(
          flex: !isDesktop ? 8 : 1,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              /// SnackBar Body
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isTablet ? size.width * 0.1 : 0,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? size.width * 0.1 : size.width * 0.05,
                  vertical: !isMobile ? size.height * 0.03 : size.height * 0.025,
                ),
                decoration: BoxDecoration(
                  color: color ?? contentType.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: isMobile ? 8 : 25,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// `title` parameter
                              Expanded(
                                flex: 3,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: isTablet || isDesktop ? size.height * 0.03 : size.height * 0.025,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  if (inMaterialBanner) {
                                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                  } else {
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  }
                                },
                                child: SvgPicture.asset(
                                  AssetsPath.failure,
                                  height: size.height * 0.022,
                                  package: 'awesome_snackbar_content',
                                ),
                              ),
                            ],
                          ),

                          /// `message` body text parameter
                          Text(
                            message,
                            style: TextStyle(
                              fontSize: size.height * 0.016,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// other SVGs in body
              Positioned(
                bottom: 0,
                left: isTablet ? size.width * 0.1 : 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    AssetsPath.bubbles,
                    height: size.height * 0.06,
                    width: size.width * 0.05,
                    color: hslDark.toColor(),
                    package: 'awesome_snackbar_content',
                  ),
                ),
              ),

              Positioned(
                top: -size.height * 0.02,
                left: isTablet ? size.width * 0.125 : size.width * 0.02,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsPath.back,
                      height: size.height * 0.06,
                      color: hslDark.toColor(),
                      package: 'awesome_snackbar_content',
                    ),
                    Positioned(
                      top: size.height * 0.015,
                      child: SvgPicture.asset(
                        assetSVG(contentType),
                        height: size.height * 0.022,
                        package: 'awesome_snackbar_content',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        !isMobile
            ? const Spacer()
            : SizedBox(
                width: size.width * 0.01,
              ),
      ],
    );
  }

  /// Reflecting proper icon based on the contentType
  String assetSVG(ContentType contentType) {
    if (contentType == ContentType.failure) {
      /// failure will show `CROSS`
      return AssetsPath.failure;
    } else if (contentType == ContentType.success) {
      /// success will show `CHECK`
      return AssetsPath.success;
    } else if (contentType == ContentType.warning) {
      /// warning will show `EXCLAMATION`
      return AssetsPath.warning;
    } else if (contentType == ContentType.help) {
      /// help will show `QUESTION MARK`
      return AssetsPath.help;
    } else {
      return AssetsPath.failure;
    }
  }
}