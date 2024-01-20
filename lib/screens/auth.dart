import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:smartfm_poc/services/auth.dart';
import 'package:smartfm_poc/storage/user_storage.dart';

enum VerificationType { phoneNumber, otp }

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Auth> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  VerificationType _verificationType = VerificationType.phoneNumber;
  String _phoneNumber = '';
  String _otp = '';
  String? _userOto = '';
  final focusedBorderColor = const Color.fromRGBO(23, 171, 144, 1);
  final fillColor = const Color.fromRGBO(243, 246, 249, 0);
  final borderColor = const Color.fromRGBO(23, 171, 144, 0.4);

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: const Color.fromRGBO(23, 171, 144, 0.4)),
    ),
  );

  void handleSubmit() async {
    try {
      if (_verificationType == VerificationType.otp) {
        final authenticateResponse =
            await AuthService().authenticate(_phoneNumber, _otp);

        await UserStorage().saveUser(authenticateResponse.user);

        Fluttertoast.showToast(
            msg: "Successfully logged in",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[800],
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
      }

      final generateOtpResponse = await AuthService().generateOtp(_phoneNumber);
      setState(() {
        _userOto = generateOtpResponse.otp.toString();
        _verificationType = VerificationType.otp;
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 200,
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 25,
                  ),
                  (_verificationType == VerificationType.phoneNumber
                      ? IntlPhoneField(
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'PK',
                          onChanged: (phone) {
                            setState(() {
                              _phoneNumber = phone.completeNumber;
                            });
                          },
                        )
                      : Pinput(
                          controller: pinController,
                          focusNode: focusNode,
                          length: 5,
                          separatorBuilder: (index) =>
                              const SizedBox(width: 20),
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          defaultPinTheme: defaultPinTheme,
                          validator: (value) {
                            return value == _userOto
                                ? null
                                : 'Otp is incorrect';
                          },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            setState(() {
                              _otp = pin;
                            });
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                                color: focusedBorderColor,
                              ),
                            ],
                          ),
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(19),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyBorderWith(
                            border: Border.all(color: Colors.redAccent),
                          ),
                        )),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: handleSubmit,
                    style: ElevatedButton.styleFrom(
                      elevation: 6.0,
                      textStyle: const TextStyle(color: Colors.white),
                      padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                    ),
                    child: const Text("Login"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
