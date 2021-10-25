import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio_quangblue/app_setting.dart';
import 'package:portfolio_quangblue/main_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  Get.put(MainController());
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'montserrat',
      ),
      home: Scaffold(
        body: Row(
          children: const <Widget>[
            Menu(),
            MainContent(),
          ],
        ),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    return Expanded(
      flex: 9,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TopBanner(key: mainController.topBannerKey),
            Summary(key: mainController.summaryKey),
            WhatIDo(key: mainController.whatIsDoKey),
            WhatIDid(key: mainController.whatIDidKey),
            Language(key: mainController.languageKey),
            Framework(key: mainController.frameworkSDKKey),
            AboutMe(key: mainController.aboutMeKey),
            ContactMe(key: mainController.contactMeKey),
            Footer(key: mainController.footerKey),
          ],
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding * 2,
        ),
        decoration: const BoxDecoration(
          color: colorDarkBlue,
          border: Border(
            right: BorderSide(
              color: colorWhite,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MenuItem(
              label: 'QB',
              onTap: () {
                Get.find<MainController>()
                    .scrollToItem(mainController.topBannerKey);
              },
            ),
            MenuItem(
              label: 'WORK',
              onTap: () {
                Get.find<MainController>()
                    .scrollToItem(mainController.whatIDidKey);
              },
            ),
            MenuItem(
              label: 'ABOUT',
              onTap: () {
                Get.find<MainController>()
                    .scrollToItem(mainController.summaryKey);
              },
            ),
            MenuItem(
              label: 'CONTACT',
              onTap: () {
                Get.find<MainController>()
                    .scrollToItem(mainController.contactMeKey);
              },
            ),
            MenuItem(
              label: 'CV',
              onTap: () {
                launch(linkCV);
              },
            ),
            const Social()
          ],
        ),
      ),
    );
  }
}

//https://drive.google.com/file/d/1e6M7WedtUXVuxigpnFcswdggx1m-Nz8A/view
// Get.find<MainController>().scrollToItem(globalKey);
class Social extends StatelessWidget {
  const Social({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          SocialItem(
            url: 'https://www.facebook.com/quangblue1603/',
            icon: FontAwesomeIcons.facebookF,
          ),
          SocialItem(
            url: 'https://github.com/QuangBlue/',
            icon: FontAwesomeIcons.githubAlt,
          ),
          SocialItem(
            url: 'tel:0908990094',
            icon: FontAwesomeIcons.phone,
          ),
        ],
      ),
    );
  }
}

class SocialItem extends StatelessWidget {
  const SocialItem({
    Key? key,
    required this.url,
    required this.icon,
  }) : super(key: key);

  final String url;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final RxBool isHover = false.obs;
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        isHover(true);
      },
      onExit: (PointerExitEvent event) {
        isHover(false);
      },
      child: InkWell(
        onTap: () {
          launch(
            url,
          );
        },
        child: Obx(
          () => FaIcon(
            icon,
            color: isHover.value ? colorTextH1Banner : colorWhite,
            size: context.width * fontPerSSmall > 24 ? 24 : 18,
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final RxBool isHover = false.obs;
    return SizedBox(
      height: 100,
      width: 30,
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: MouseRegion(
            onEnter: (PointerEnterEvent event) {
              isHover(true);
            },
            onExit: (PointerExitEvent event) {
              isHover(false);
            },
            child: RotatedBox(
              quarterTurns: -1,
              child: Obx(
                () => Text(
                  label,
                  style: TextStyle(
                    color: isHover.value ? colorTextH1Banner : colorWhite,
                    fontSize: context.width * fontPerSSmall > 20 ? 20 : 18,
                    fontWeight:
                        isHover.value ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopBanner extends StatelessWidget {
  const TopBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: defaultDuration,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.width > 1120
            ? horizontalPaddingDesktop
            : horizontalPaddingNotDesktop,
      ),
      color: colorDarkBlue,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Title(
            title: 'who.',
            color: colorTextH1Banner,
          ),
          Text(
            "Hello, my name's ",
            style: TextStyle(
              fontSize: context.width * fontPerMedium,
              color: colorTextWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          DefaultTextStyle(
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: colorTextH1Banner,
              fontSize: context.width * fontPerLarge,
              fontFamily: 'montserrat',
            ),
            child: AnimatedTextKit(
              totalRepeatCount: 1,
              animatedTexts: <TyperAnimatedText>[
                TyperAnimatedText(
                  'Quang Blue',
                  speed: const Duration(milliseconds: 200),
                ),
              ],
            ),
          ),
          Text(
            "I'm a Flutter Developers",
            style: TextStyle(
              fontSize: context.width * fontPerMedium,
              color: colorTextWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: context.width < 480 ? 30 : 60,
          child: Divider(
            color: color == colorTextH1Banner ? colorWhite : colorDarkBlue,
            thickness: 4,
          ),
        ),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: context.width * fontPerMedium > 40
                  ? 40
                  : context.width * fontPerMedium,
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        )
      ],
    );
  }
}

class WhatIDo extends StatelessWidget {
  const WhatIDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    final GlobalKey contactMeKey = mainController.contactMeKey;
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: defaultDuration,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.width > 1120
            ? horizontalPaddingDesktop
            : horizontalPaddingNotDesktop,
        vertical: defaultPadding * 2,
      ),
      color: colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Title(
            title: 'what i do.',
            color: colorDarkBlue,
          ),
          const SizedBox(height: defaultPadding),
          Text(
            'I enjoy creating delightful, human-centered digital experiences.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: context.width * fontPerSmall > 60
                  ? 60
                  : context.width * fontPerSmall,
            ),
          ),
          const SizedBox(height: defaultPadding * 2),
          DefaultTextStyle(
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: colorDarkBlue,
              fontSize: context.width * fontPerLarge,
              fontFamily: 'montserrat',
            ),
            child: AnimatedTextKit(
              totalRepeatCount: 1,
              repeatForever: true,
              animatedTexts: <TypewriterAnimatedText>[
                TypewriterAnimatedText(
                  'Think. Make. Solve.',
                  speed: const Duration(milliseconds: 400),
                ),
              ],
            ),
          ),
          // Text(
          //   'Think. Make. Solve.',
          //   style: TextStyle(
          //     fontWeight: FontWeight.w900,
          //     fontSize: context.width * fontPerLarge,
          //     height: 1,
          //   ),
          // ),
          const SizedBox(height: defaultPadding),
          InkWell(
            onTap: () {
              mainController.scrollToItem(contactMeKey);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal:
                    context.isPhone ? defaultPadding * 2 : defaultPadding * 4,
                vertical: context.isPhone ? defaultPadding : defaultPadding * 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: colorDarkBlue,
              ),
              child: Text(
                'Contact me',
                style: TextStyle(
                  color: colorWhite,
                  fontSize: context.width * fontPerSSmall > 24
                      ? 24
                      : context.width * fontPerSSmall,
                  fontWeight: FontWeight.bold,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WhatIDid extends StatelessWidget {
  const WhatIDid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding * 2),
      color: colorDarkBlue,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width > 1120
                  ? horizontalPaddingDesktop
                  : horizontalPaddingNotDesktop,
            ),
            child: const Title(
              title: 'what i did.',
              color: colorTextH1Banner,
            ),
          ),
          const SizedBox(height: defaultPadding * 2),
          const Project(
            title: '01. Comic App & Website',
            description:
                '- Comic reading application with comic store built from Back-end (python beautifulsoup scraping)',
            teamSize: '- 1',
            responsiblities:
                '- Build the entire UI/UX and features for the app',
            accomplishments:
                '''- Learn how to build responsive UX/UI design with Flutter.\n- Learn how to use Python Scraping to build databases.\n- Learn to manage data with millions of images.\n- Learn to work with AWS S3 (Restfull API S3)\n- Learn how to use Firebase Auth, Firestore, Firebase Storage.\n- Learn how to build a database with Firestore.\n- Learn how to manage state with GetX, Flutter Bloc.''',
            technologies:
                '''- Frontend: Flutter\n- Backend: Firebase Service''',
            urlGithub: '',
            urlWebsite: 'https://sumanga.net/home',
          ),
          SizedBox(
            height: context.isPhone ? defaultPadding * 4 : defaultPadding * 10,
          ),
          const Project(
            title: '02. Movie App & Website',
            description:
                '- Movie application with movie store from Fshare and information from TMDB API.',
            teamSize: '- 1',
            responsiblities:
                '- Build the entire UI/UX and features for the app',
            accomplishments:
                '''- Learn how to build responsive UX/UI design with Flutter.\n- Learn how to work with Fshare and TMDB APIs.\n- Learn how to use Firebase Auth, Firestore, Firebase Storage.\n- Learn how to build a database with Firestore.\n- Learn how to manage state with GetX, Flutter Bloc.\n- Learn how to manage source code with Git.''',
            technologies:
                '''- Frontend: Flutter\n- Backend: Firebase Service''',
            urlGithub: '',
            urlWebsite: 'https://fflix-8dda6.web.app/home',
          ),
          SizedBox(
            height: context.isPhone ? defaultPadding * 4 : defaultPadding * 10,
          ),
          const Project(
            title: '03. Sale Management Software',
            description:
                '- Business management software on e-commerce platforms like Shopee Lazada.',
            teamSize: '- 1',
            responsiblities:
                '- Build the entire UI/UX and features for the app',
            accomplishments:
                '''- Learn how to build UI/UX from PyQt5 Python.\n- Learn to use Flask and Fast-Api as Back-End.\n- Learn how to work with Restfull API.\n- Learn how to manage source code with Git.''',
            technologies:
                '''- Frontend: PyQt5, CSS\n- Backend: Python Flask, MongoDB''',
            urlGithub: '',
            urlWebsite: 'https://fflix-8dda6.web.app/home',
          ),
          SizedBox(
            height: context.isPhone ? defaultPadding * 4 : defaultPadding * 10,
          ),
        ],
      ),
    );
  }
}

class Project extends StatelessWidget {
  const Project({
    Key? key,
    required this.title,
    required this.description,
    required this.teamSize,
    required this.responsiblities,
    required this.accomplishments,
    required this.technologies,
    required this.urlGithub,
    required this.urlWebsite,
  }) : super(key: key);

  final String title;
  final String description;
  final String teamSize;
  final String responsiblities;
  final String accomplishments;
  final String technologies;
  final String urlGithub;
  final String urlWebsite;

  @override
  Widget build(BuildContext context) {
    return context.width < 1120
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: context.width * fontPerSSmall > 24
                      ? 24
                      : context.width * fontPerSSmall,
                  color: colorTextH1Banner,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: context.isPhone ? defaultPadding : defaultPadding * 2,
              ),
              ProjectDetailItem(
                title: 'Description',
                content: description,
              ),
              ProjectDetailItem(
                title: 'Team Size',
                content: teamSize,
              ),
              ProjectDetailItem(
                title: 'Responsiblities',
                content: responsiblities,
              ),
              ProjectDetailItem(
                title: 'Accomplishments',
                content: accomplishments,
              ),
              ProjectDetailItem(
                title: 'Technologies',
                content: technologies,
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      launch(urlGithub);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding * 1.2,
                        horizontal: defaultPadding * 1.5,
                      ),
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.githubAlt,
                            size: context.width * fontPerSSmall > 20
                                ? 20
                                : context.width * fontPerSSmall,
                            color: colorDarkBlue,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Github',
                            style: TextStyle(
                              color: colorDarkBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: context.width * fontPerSSmall > 20
                                  ? 20
                                  : context.width * fontPerSSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: defaultPadding / 2),
                  InkWell(
                    onTap: () {
                      launch(urlWebsite);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding * 1.2,
                        horizontal: defaultPadding * 1.5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Go To Website',
                        style: TextStyle(
                          color: colorWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: context.width * fontPerSSmall > 20
                              ? 20
                              : context.width * fontPerSSmall,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.isPhone ? defaultPadding : defaultPadding * 2,
              ),
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(prImg),
                  ),
                ),
              ),
            ],
          )
        : Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: defaultPadding * 2,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 2,
                        color: colorWhite,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: context.width * fontPerSSmall > 24
                              ? 24
                              : context.width * fontPerSSmall,
                          color: colorTextH1Banner,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 4),
                      ProjectDetailItem(
                        title: 'Description',
                        content: description,
                      ),
                      ProjectDetailItem(
                        title: 'Team Size',
                        content: teamSize,
                      ),
                      ProjectDetailItem(
                        title: 'Responsiblities',
                        content: responsiblities,
                      ),
                      ProjectDetailItem(
                        title: 'Accomplishments',
                        content: accomplishments,
                      ),
                      ProjectDetailItem(
                        title: 'Technologies',
                        content: technologies,
                      ),
                      Row(
                        children: <Widget>[
                          CustomButtonGithub(
                            urlGithub: urlGithub,
                          ),
                          const SizedBox(width: defaultPadding / 2),
                          CustomButtonWebsite(
                            urlWebsite: urlWebsite,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(prImg),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

class CustomButtonGithub extends StatefulWidget {
  const CustomButtonGithub({
    Key? key,
    required this.urlGithub,
  }) : super(key: key);

  final String urlGithub;

  @override
  State<CustomButtonGithub> createState() => _CustomButtonGithubState();
}

class _CustomButtonGithubState extends State<CustomButtonGithub> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (PointerExitEvent event) {
        setState(() {
          isHover = false;
        });
      },
      child: InkWell(
        onTap: () {
          launch(widget.urlGithub);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding * 1.5,
            horizontal: defaultPadding * 2.5,
          ),
          decoration: BoxDecoration(
            color: isHover ? Colors.blue : colorWhite,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.githubAlt,
                size: 22,
                color: isHover ? colorWhite : colorDarkBlue,
              ),
              const SizedBox(width: 8),
              Text(
                'Github',
                style: TextStyle(
                  color: isHover ? colorWhite : colorDarkBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButtonWebsite extends StatefulWidget {
  const CustomButtonWebsite({
    Key? key,
    required this.urlWebsite,
  }) : super(key: key);

  final String urlWebsite;

  @override
  State<CustomButtonWebsite> createState() => _CustomButtonWebsiteState();
}

class _CustomButtonWebsiteState extends State<CustomButtonWebsite> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (PointerExitEvent event) {
        setState(() {
          isHover = false;
        });
      },
      child: InkWell(
        onTap: () {
          launch(widget.urlWebsite);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding * 1.5,
            horizontal: defaultPadding * 2.5,
          ),
          decoration: BoxDecoration(
            color: isHover ? colorWhite : Colors.blue,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Go To Website',
            style: TextStyle(
              color: isHover ? colorDarkBlue : colorWhite,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectDetailItem extends StatelessWidget {
  const ProjectDetailItem({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: context.isPhone ? defaultPadding : defaultPadding * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$title :',
            style: TextStyle(
              fontSize: context.width * fontPerSSmall > 20
                  ? 20
                  : context.width * fontPerSSmall,
              color: colorWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: context.width * fontPerSSmall > 20
                  ? 20
                  : context.width * fontPerSSmall,
              color: colorWhite,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Language extends StatelessWidget {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width > 1120
            ? horizontalPaddingDesktop
            : horizontalPaddingNotDesktop,
        vertical: defaultPadding * 2,
      ),
      color: colorWhite,
      child: Column(
        children: const <Widget>[
          Title(
            title: 'language.',
            color: colorDarkBlue,
          ),
          AnimatedLinearProgressIndicator(
            label: 'Dart',
            percentage: 0.7,
            colorIndicator: colorBlue,
            colorText: colorBlack,
          ),
          AnimatedLinearProgressIndicator(
            label: 'HTML',
            percentage: 0.7,
            colorIndicator: colorBlue,
            colorText: colorBlack,
          ),
          AnimatedLinearProgressIndicator(
            label: 'CSS',
            percentage: 0.6,
            colorIndicator: colorBlue,
            colorText: colorBlack,
          ),
          AnimatedLinearProgressIndicator(
            label: 'Javascript',
            percentage: 0.6,
            colorIndicator: colorBlue,
            colorText: colorBlack,
          ),
          AnimatedLinearProgressIndicator(
            label: 'Python',
            percentage: 0.8,
            colorIndicator: colorBlue,
            colorText: colorBlack,
          ),
        ],
      ),
    );
  }
}

class AnimatedLinearProgressIndicator extends StatelessWidget {
  const AnimatedLinearProgressIndicator({
    Key? key,
    required this.label,
    required this.percentage,
    required this.colorIndicator,
    required this.colorText,
  }) : super(key: key);

  final String label;
  final double percentage;
  final Color colorIndicator;
  final Color colorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: defaultPadding,
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: percentage),
        duration: const Duration(milliseconds: 300),
        builder: (BuildContext context, double value, Widget? child) => Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    color: colorText,
                    fontSize: context.width * fontPerSmall > 20
                        ? 20
                        : context.width * fontPerSmall,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${(value * 100).toInt()}%',
                  style: TextStyle(
                    color: colorText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding / 2),
            LinearProgressIndicator(
              value: value,
              color: colorIndicator,
              minHeight: 10,
            )
          ],
        ),
      ),
    );
  }
}

class Framework extends StatelessWidget {
  const Framework({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width > 1120
            ? horizontalPaddingDesktop
            : horizontalPaddingNotDesktop,
        vertical: defaultPadding * 2,
      ),
      color: colorDarkBlue,
      child: Column(
        children: const <Widget>[
          Title(
            title: 'framework.',
            color: colorTextH1Banner,
          ),
          AnimatedLinearProgressIndicator(
            label: 'Flutter',
            percentage: 0.6,
            colorIndicator: Colors.blue,
            colorText: colorWhite,
          ),
          AnimatedLinearProgressIndicator(
            label: 'PyQt5',
            percentage: 0.7,
            colorIndicator: Colors.blue,
            colorText: colorWhite,
          ),
          AnimatedLinearProgressIndicator(
            label: 'Flask',
            percentage: 0.5,
            colorIndicator: Colors.blue,
            colorText: colorWhite,
          ),
          AnimatedLinearProgressIndicator(
            label: 'ReactJs',
            percentage: 0.5,
            colorIndicator: Colors.blue,
            colorText: colorWhite,
          ),
          AnimatedLinearProgressIndicator(
            label: 'NodeJs',
            percentage: 0.5,
            colorIndicator: Colors.blue,
            colorText: colorWhite,
          ),
          AnimatedLinearProgressIndicator(
            label: 'Firebase',
            percentage: 0.7,
            colorIndicator: Colors.blue,
            colorText: colorWhite,
          ),
          AnimatedLinearProgressIndicator(
            label: 'MongoDB',
            percentage: 0.6,
            colorIndicator: Colors.blue,
            colorText: colorWhite,
          ),
        ],
      ),
    );
  }
}

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: defaultDuration,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.width > 1120
            ? horizontalPaddingDesktop
            : horizontalPaddingNotDesktop,
        vertical: defaultPadding * 2,
      ),
      color: colorWhite,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding * 2),
        decoration: BoxDecoration(
          border: Border.all(
            width: context.width < 480 ? 2 : 10,
            color: colorDarkBlue,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: context.width < 700
            ? Column(
                children: <Widget>[
                  Image.asset(face1),
                  Text(
                    aboutMe,
                    style: TextStyle(
                      fontSize: context.width * fontPerSSmall > 24
                          ? 24
                          : context.width * fontPerSSmall,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(face1),
                  Expanded(
                    child: Text(
                      aboutMe,
                      style: TextStyle(
                        fontSize: context.width * fontPerSSmall > 24
                            ? 24
                            : context.width * fontPerSSmall,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class ButtonSocialCircle extends StatefulWidget {
  const ButtonSocialCircle({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;

  @override
  State<ButtonSocialCircle> createState() => _ButtonSocialCircleState();
}

class _ButtonSocialCircleState extends State<ButtonSocialCircle> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (PointerExitEvent event) {
        setState(() {
          isHover = false;
        });
      },
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          height: context.isPhone ? 30 : 50,
          width: context.isPhone ? 30 : 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: colorDarkBlue,
              width: 2,
            ),
            color: isHover ? colorDarkBlue : colorWhite,
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: isHover ? colorWhite : colorDarkBlue,
              size: context.isPhone ? 14 : 16,
            ),
          ),
        ),
      ),
    );
  }
}

class ContactMe extends StatelessWidget {
  const ContactMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: defaultDuration,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.width > 1120
            ? horizontalPaddingDesktop
            : horizontalPaddingNotDesktop,
        vertical: defaultPadding * 2,
      ),
      color: colorDarkBlue,
      child: Container(
        padding: EdgeInsets.all(
          context.isPhone ? defaultPadding : defaultPadding * 4,
        ),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(context.isPhone ? 10 : 50),
        ),
        child: context.width < 1050
            ? Column(
                children: <Widget>[
                  const Title(
                    title: 'Say hello 👋',
                    color: colorDarkBlue,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    'Let’s Work Together.',
                    style: TextStyle(
                      fontSize: context.width * fontPerMedium > 40
                          ? 40
                          : context.width * fontPerMedium,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    'I’d love to meet up with you to discuss your venture, and potential collaborations.',
                    style: TextStyle(
                      fontSize: context.width * fontPerSSmall > 24
                          ? 24
                          : context.width * fontPerSSmall,
                      color: colorGrey,
                    ),
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  Row(
                    children: <Widget>[
                      ButtonSocialCircle(
                        onTap: () {
                          launch('mailto:quangblue1603@gmail.com');
                        },
                        icon: FontAwesomeIcons.solidEnvelope,
                      ),
                      const SizedBox(width: defaultPadding),
                      Text(
                        'quangblue1603@gmail.com',
                        style: TextStyle(
                          fontSize: context.width * fontPerSSmall > 24
                              ? 24
                              : context.width * fontPerSSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    children: <Widget>[
                      ButtonSocialCircle(
                        onTap: () {
                          launch('https://www.facebook.com/quangblue1603/');
                        },
                        icon: FontAwesomeIcons.facebookF,
                      ),
                      const SizedBox(width: defaultPadding),
                      Text(
                        'fb.me/quangblue1603',
                        style: TextStyle(
                          fontSize: context.width * fontPerSSmall > 24
                              ? 24
                              : context.width * fontPerSSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    children: <Widget>[
                      ButtonSocialCircle(
                        onTap: () {
                          launch(
                            'tel:0908990094',
                          );
                        },
                        icon: FontAwesomeIcons.mobile,
                      ),
                      const SizedBox(width: defaultPadding),
                      Text(
                        '+84 908 990094',
                        style: TextStyle(
                          fontSize: context.width * fontPerSSmall > 24
                              ? 24
                              : context.width * fontPerSSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  const CustomTextField(
                    label: 'Name',
                    icon: FontAwesomeIcons.user,
                  ),
                  const CustomTextField(
                    label: 'Email',
                    icon: FontAwesomeIcons.paperPlane,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: defaultPadding,
                    ),
                    child: TextField(
                      onChanged: (String value) {},
                      cursorColor: colorDarkBlue,
                      keyboardType: TextInputType.multiline,
                      minLines: 5, //Normal textInputField will be displayed
                      maxLines: 5,

                      decoration: InputDecoration(
                        hintText: 'Message',
                        hoverColor: Colors.transparent,
                        focusColor: colorWhite,
                        fillColor: colorGrey.withOpacity(0.1),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: defaultPadding * 1.5,
                          horizontal: defaultPadding,
                        ),
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorDarkBlue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 70),
                          child: Icon(
                            FontAwesomeIcons.commentDots,
                            color: colorDarkBlue,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding * 1.5,
                        horizontal: defaultPadding * 3,
                      ),
                      decoration: BoxDecoration(
                        color: colorDarkBlue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Let's Talk",
                        style: TextStyle(
                          color: colorWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: context.width * fontPerSmall > 24
                              ? 24
                              : context.width * fontPerSmall,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Title(
                            title: 'Say hello 👋',
                            color: colorDarkBlue,
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          const Text(
                            'Let’s Work Together.',
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          const Text(
                            'I’d love to meet up with you to discuss your venture, and potential collaborations.',
                            style: TextStyle(
                              fontSize: 20,
                              color: colorGrey,
                            ),
                          ),
                          const SizedBox(height: defaultPadding * 4),
                          Row(
                            children: <Widget>[
                              ButtonSocialCircle(
                                onTap: () {
                                  launch('mailto:quangblue1603@gmail.com');
                                },
                                icon: FontAwesomeIcons.solidEnvelope,
                              ),
                              const SizedBox(width: defaultPadding),
                              const Text('quangblue1603@gmail.com'),
                            ],
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          Row(
                            children: <Widget>[
                              ButtonSocialCircle(
                                onTap: () {
                                  launch(
                                    'https://www.facebook.com/quangblue1603/',
                                  );
                                },
                                icon: FontAwesomeIcons.facebookF,
                              ),
                              const SizedBox(width: defaultPadding),
                              const Text('fb.me/quangblue1603'),
                            ],
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          Row(
                            children: <Widget>[
                              ButtonSocialCircle(
                                onTap: () {
                                  launch(
                                    'tel:0908990094',
                                  );
                                },
                                icon: FontAwesomeIcons.mobile,
                              ),
                              const SizedBox(width: defaultPadding),
                              const Text('+84 908 990094'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const CustomTextField(
                          label: 'Name',
                          icon: FontAwesomeIcons.user,
                        ),
                        const CustomTextField(
                          label: 'Email',
                          icon: FontAwesomeIcons.paperPlane,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: defaultPadding,
                          ),
                          child: TextField(
                            onChanged: (String value) {},
                            cursorColor: colorDarkBlue,
                            keyboardType: TextInputType.multiline,
                            minLines:
                                5, //Normal textInputField will be displayed
                            maxLines: 5,

                            decoration: InputDecoration(
                              hintText: 'Message',
                              hoverColor: Colors.transparent,
                              focusColor: colorWhite,
                              fillColor: colorGrey.withOpacity(0.1),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: defaultPadding * 1.5,
                                horizontal: defaultPadding,
                              ),
                              filled: true,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colorDarkBlue,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(bottom: 70),
                                child: Icon(
                                  FontAwesomeIcons.commentDots,
                                  color: colorDarkBlue,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding * 1.5,
                              horizontal: defaultPadding * 3,
                            ),
                            decoration: BoxDecoration(
                              color: colorDarkBlue,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Let's Talk",
                              style: TextStyle(
                                color: colorWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: context.width * fontPerSmall > 24
                                    ? 24
                                    : context.width * fontPerSmall,
                              ),
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: defaultPadding,
      ),
      child: TextField(
        onChanged: (String value) {},
        cursorColor: colorDarkBlue,
        decoration: InputDecoration(
          hintText: label,
          hoverColor: Colors.transparent,
          focusColor: colorWhite,
          fillColor: colorGrey.withOpacity(0.1),
          contentPadding: const EdgeInsets.symmetric(
            vertical: defaultPadding * 1.5,
            horizontal: defaultPadding,
          ),
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: colorDarkBlue,
              width: 2,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          suffixIcon: Icon(
            icon,
            color: colorDarkBlue,
            size: 16,
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: defaultDuration,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.width > 1120
            ? horizontalPaddingDesktop
            : horizontalPaddingNotDesktop,
        vertical: defaultPadding * 2,
      ),
      color: colorDarkBlue,
      child: Column(
        children: const <Widget>[
          Text(
            nameImg,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSizeLarge,
              color: colorWhite,
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          SizedBox(
            width: 400,
            child: Text(
              footerLogan,
              style: TextStyle(
                fontSize: fontSizeMedium,
                color: colorWhite,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: defaultPadding * 4,
          ),
          Divider(
            color: colorWhite,
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Text(
            footerText,
            style: TextStyle(
              color: colorWhite,
            ),
          ),
        ],
      ),
    );
  }
}

class Summary extends StatelessWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: defaultDuration,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.width > 1120
            ? horizontalPaddingDesktop - 40
            : horizontalPaddingNotDesktop,
        vertical: defaultPadding * 4,
      ),
      color: colorDarkBlue,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: defaultDuration,
        ),
        padding: const EdgeInsets.all(
          defaultPadding * 2,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: context.width < 480 ? 2 : 10,
            color: colorWhite,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Title(
              title: 'summary.',
              color: colorTextH1Banner,
            ),
            const SizedBox(height: defaultPadding),
            Text(
              summary,
              style: TextStyle(
                fontSize: context.width * fontPerSSmall > 24
                    ? 24
                    : context.width * fontPerSSmall,
                color: colorWhite,
              ),
            ),
            const SizedBox(height: defaultPadding * 2),
          ],
        ),
      ),
    );
  }
}
