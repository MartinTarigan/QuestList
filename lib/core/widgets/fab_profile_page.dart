import 'package:flutter/material.dart';
import 'package:Todos/core/constant/profile.dart';
import 'package:Todos/core/constant/typography.dart';
import 'package:Todos/core/theme/base_color.dart';

class FABProfilePage extends StatefulWidget {
  const FABProfilePage({
    super.key,
  });

  @override
  State<FABProfilePage> createState() => _FABProfilePageState();
}

class _FABProfilePageState extends State<FABProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: FloatingActionButton(
        splashColor: BaseColors.primaryBlue,
        backgroundColor: BaseColors.purple,
        onPressed: () async {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: BaseColors.white,
                title: const Text("More about me"),
                actions: [
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Get In Touch",
                        style: Font.tertiaryBodyLarge,
                      ),
                      const SizedBox(height: 5),
                      const ProfileAttributeWidget(
                        keyName: 'Email',
                        value: Developer.email,
                      ),
                      const ProfileAttributeWidget(
                        keyName: 'Instagram',
                        value: Developer.instagram,
                      ),
                      const ProfileAttributeWidget(
                        keyName: 'LinkedIn',
                        value: Developer.linkedin,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Trivial",
                        style: Font.tertiaryBodyLarge,
                      ),
                      const ProfileAttributeWidget(
                        keyName: 'Hobbies',
                        value: Developer.hobby,
                      ),
                      const ProfileAttributeWidget(
                        keyName: 'Zodiac',
                        value: Developer.zodiac,
                      ),
                      const ProfileAttributeWidget(
                        keyName: 'Fun Fact',
                        value: Developer.funFact,
                      ),
                      const ProfileAttributeWidget(
                        keyName: 'Favorite Quotes',
                        value: Developer.favQuote,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.details,
          color: BaseColors.white,
        ),
      ),
    );
  }
}

class ProfileAttributeWidget extends StatelessWidget {
  final String keyName;
  final String value;
  const ProfileAttributeWidget({
    super.key,
    required this.keyName,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            keyName,
            style: Font.tertiaryBodyMedium,
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: BaseColors.primaryBlue),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
