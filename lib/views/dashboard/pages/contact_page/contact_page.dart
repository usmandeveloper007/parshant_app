import 'package:flutter/material.dart';
import 'package:parshant_app/core/constants/Appfont.dart';


class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10,),
          Container(
            height: 45,
             width: double.infinity,
             color: Colors.grey.shade300,
            child:  Center(child:  Text("HelpDesk" , style: AppTextStyles.fontSize20(),)),
          ),
          const SizedBox(height: 10,),
          fundCard(
              leadingIcon: Icons.call,
              titleText: "Contact me",
              subtitleText: "Ask any question via phone",
              widgetNumber: 1,
              context: context),
          fundCard(
              leadingIcon: Icons.message,
              titleText: "Contact  messages",
              subtitleText: "Ask any question via contact messages",
              widgetNumber: 1,
              context: context),
          fundCard(
              leadingIcon: Icons.telegram,
              titleText: "Telegram",
              subtitleText: "Ask any question via Telegram",
              widgetNumber: 1,
              context: context),
          fundCard(
              leadingIcon: Icons.email,
              titleText: "Send email",
              subtitleText: "Ask any question via email",
              widgetNumber: 1,
              context: context),
          specialCard(),
        ],
      ),
    );
  }

  Widget fundCard({
    required IconData leadingIcon,
    required String titleText,
    required String subtitleText,
    required int widgetNumber,
    required BuildContext context,
  }) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 7,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Icon(
              leadingIcon,
              size: 30,
              color: Colors.red,
            ),
            title: Text(
              titleText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(subtitleText),
            trailing: InkWell(
              onTap: () {
                if (widgetNumber == 1) {}
              },
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget specialCard() {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 7,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Image.asset(
              "assests/image/whtashppimage2.png",
              height: 50,
            ),
            title: const Text(
              "Whatsapp message",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("Ask any question via Whatsapp messages"),
            trailing: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
