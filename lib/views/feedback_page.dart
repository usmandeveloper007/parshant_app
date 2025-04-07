import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parshant_app/core/constants/Appfont.dart';
import 'package:parshant_app/widgets/custom_button.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.blue,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Feedback",
                      style: AppTextStyles.fontSize18(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 7,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Send us your feedback!",
                          style: AppTextStyles.fontSize18(),
                        ),
                        Text(
                          "Please share your suggestion or found a bug?",
                          style: AppTextStyles.fontSize15(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextField(
                            maxLength: 100,
                            decoration: InputDecoration(
                              labelText: "Title",
                              counterText: "",
                              labelStyle: AppTextStyles.fontSize18(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextField(
                            maxLines: 5,
                            maxLength: 300,
                            decoration: InputDecoration(
                              labelText: "Your Message",
                              counterText: "",
                              labelStyle: AppTextStyles.fontSize18(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  onPressed: () {},
                  backgroundColour: Colors.blue,
                  minimumSize: const Size(300, 70),
                  childWidget: Text(
                    "Submit",
                    style: TextStyle(fontSize:10.sp,color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

