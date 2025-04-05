import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parshant_app/core/utils/device_height_width.dart';
import 'package:parshant_app/providers/jodi_game_provider.dart';
import 'package:parshant_app/views/dashboard/pages/bet_history/show_your_number_page/show_number_page.dart';
import 'package:parshant_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class JodiGameScreen extends StatefulWidget {
  final String gameName;
  final String resulTime;

  const JodiGameScreen(
      {super.key, required this.gameName, required this.resulTime});

  @override
  JodiGameScreenState createState() => JodiGameScreenState();
}

class JodiGameScreenState extends State<JodiGameScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => isLoading = false);
    });

    Future.microtask(() {
      final provider =
          Provider.of<JodiGameChangeNotifier>(context, listen: false);
      provider.resetControllers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jodi Game")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<JodiGameChangeNotifier>(
              builder: (context, provider, child) {
                return Stack(
                  children: [
                    _buildGridView(provider),
                    _buildBottomSection(provider),
                    _buildNoteBanner(),
                  ],
                );
              },
            ),
    );
  }

  /// *GridView for number selection*
  Widget _buildGridView(JodiGameChangeNotifier provider) {
    return Padding(
      // yhe rhethi h abhi responsive krni
      padding:   EdgeInsets.only(bottom: 70.0, top: 60),
      child: GridView.builder(
        gridDelegate:    SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 0.9.w,
        ),
        itemCount: 100,
        cacheExtent: 100000,
        itemBuilder: (context, index) {
          String displayNumber =
              index == 99 ? "00" : (index + 1).toString().padLeft(2, '0');

          return Column(
            children: [
              _buildNumberBox(displayNumber),
              const SizedBox(height: 6),
              _buildTextField(index, provider),
            ],
          );
        },
      ),
    );
  }

  /// *Single number box UI*
  Widget _buildNumberBox(String number) {
    return Container(
       width: ScreenDimensions.width*0.1562 ,
      height:  35 , // ScreenDimensions.height*0.0358,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(5),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  /// *Text field for entering amount*
  Widget _buildTextField(int index, JodiGameChangeNotifier provider) {
    return SizedBox(
      width: ScreenDimensions.width*0.1562,
      height: 35 , // ScreenDimensions.height*0.0358,
      child: TextField(
        controller: provider.textEditingControllers[index],
        focusNode: provider.focusNodes[index],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
           contentPadding: EdgeInsets.zero,
        ),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        style:  TextStyle(fontSize: 16.sp ,),
        inputFormatters: [
          LengthLimitingTextInputFormatter(4),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) =>
            provider.updateList(index + 1 == 100 ? 00 : index + 1, value),
      ),
    );
  }

  /// *Bottom section with Total Amount & Submit button*
  Widget _buildBottomSection(JodiGameChangeNotifier provider) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTotalAmountBox(provider),
          SizedBox(width: ScreenDimensions.width * 0.04),
          _buildSubmitButton(provider, context),
        ],
      ),
    );
  }

  /// *Total amount box UI*
  Widget _buildTotalAmountBox(JodiGameChangeNotifier provider) {
    return Container(
      height: max(ScreenDimensions.height * 0.048, 40),
      width: ScreenDimensions.width * 0.40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              ("Total"),
            ),
            ValueListenableBuilder<num>(
              valueListenable: provider.totalAmount,
              builder: (context, value, child) {
                return Text(
                  "₹$value",
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// *Submit button*
  Widget _buildSubmitButton(
      JodiGameChangeNotifier provider, BuildContext context) {
    return CustomButton(
      onPressed: () => _handleSubmit(provider, context),
      backgroundColour: Colors.green,
      minimumSize: Size(
        ScreenDimensions.width * 0.40,
        max(ScreenDimensions.height * 0.048, 40),
      ),
      childWidget: const FittedBox(
        fit: BoxFit.scaleDown,
        child: Text("Submit",
            maxLines: 1,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  /// *Handle Submit Logic*
  void _handleSubmit(JodiGameChangeNotifier provider, BuildContext context) {
    if (provider.totalAmount.value < 10) {
      CustomFlushBar.showFlushBar(
          message: "minimum 10 rupees Allowed",
          context: context,
          backgroundColor: Colors.green);
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowNumberPage(
          showStack: true,
          totalAmount: provider.totalAmount.value,
          gameName: widget.gameName,
          chooseNumberList: provider.containsValue.value,
          date: widget.resulTime,
        ),
      ),
    );
  }

  /// *Bottom Note Banner*
  Widget _buildNoteBanner() {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const AutoSizeText(
        "Note: Ek Number ka minimum amount ₹10 h, Nhi tho Number na add hoga , Na hi uspe laga Amount",
        style: TextStyle(
            fontSize: 16 ,  fontWeight: FontWeight.bold, color: Colors.black),
        maxLines: 2,
     minFontSize: 9,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}



