import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpVerifScreen extends StatefulWidget {
  final String verificationId;

  OtpVerifScreen({required this.verificationId});

  @override
  _OtpVerifScreenState createState() => _OtpVerifScreenState();
}

class _OtpVerifScreenState extends State<OtpVerifScreen> {
  final _otpController = TextEditingController();

  Future<void> verifyOtp() async {
    final smsCode = _otpController.text.trim();

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Verifikasi Berhasil!")),
      );

      print("Pengguna berhasil masuk: ${userCredential.user?.uid}");
    } catch (e) {
      print("Error saat verifikasi OTP: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kode OTP salah")),
      );
    }
  }

  void resendOtp() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("OTP telah dikirim ulang.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logoverif.png',
                height: 200,
              ),
              SizedBox(height: 32),
              Text(
                "OTP Verification",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Enter the OTP sent to your mobile number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 32),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(fontSize: 24, letterSpacing: 8),
              ),
              SizedBox(height: 32),
              TextButton(
                onPressed: resendOtp,
                child: Text(
                  "Resend OTP",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: verifyOtp,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    "Verify",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
