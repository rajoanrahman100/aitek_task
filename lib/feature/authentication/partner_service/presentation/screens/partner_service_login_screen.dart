import 'package:aitek_task/core/theme/style.dart';
import 'package:aitek_task/core/utils/app_navigation.dart';
import 'package:aitek_task/core/widgets/custom_button.dart';
import 'package:aitek_task/core/widgets/custom_text_field.dart';
import 'package:aitek_task/core/widgets/responsive_content.dart';
import 'package:aitek_task/feature/authentication/partner_service/presentation/cubit/partner_login_cubit.dart';
import 'package:aitek_task/feature/authentication/partner_service/presentation/cubit/partner_login_state.dart';
import 'package:aitek_task/feature/partner_signal_archive/presentation/partner_signal_archive_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartnerServiceLoginScreen extends StatefulWidget {
  const PartnerServiceLoginScreen({super.key});

  @override
  State<PartnerServiceLoginScreen> createState() =>
      _PartnerServiceLoginScreenState();
}

class _PartnerServiceLoginScreenState extends State<PartnerServiceLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginIdController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _loginIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _submitLogin() {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    context.read<PartnerLoginCubit>().login(
      int.parse(_loginIdController.text.trim()),
      _passwordController.text.trim(),
    );
  }

  String? _validateLoginId(String? value) {
    final loginId = value?.trim() ?? '';

    if (loginId.isEmpty) {
      return 'Login ID is required';
    }

    if (int.tryParse(loginId) == null) {
      return 'Login ID must be a number';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PartnerLoginCubit, PartnerLoginState>(
      listener: (context, state) {
        if (state is PartnerLoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is PartnerLoginSuccess) {
          AppNavigator.push(context, const PartnerSignalArchiveScreen());
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Login successful')));
        }
      },
      builder: (context, state) {
        final isLoading = state is PartnerLoginLoading;

        return Scaffold(
          appBar: AppBar(title: const Text('Partner Service Login')),
          body: SafeArea(
            child: ResponsiveContent(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back',
                              style: kBoldTextStyle.copyWith(fontSize: 24),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Sign in with your Partner Service credentials.',
                              style: kRegularTextStyle.copyWith(
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text('Login ID', style: kMediumTextStyle),
                            const SizedBox(height: 8),
                            CustomTextField(
                              controller: _loginIdController,
                              hintText: 'Enter login ID',
                              keyboardType: TextInputType.number,
                              validator: _validateLoginId,
                              enabled: !isLoading,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 14, right: 10),
                                child: Icon(Icons.person_outline, size: 20),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text('Password', style: kMediumTextStyle),
                            const SizedBox(height: 8),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'Enter password',
                              obscureText: _obscurePassword,
                              validator: _validatePassword,
                              enabled: !isLoading,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 14, right: 10),
                                child: Icon(Icons.lock_outline, size: 20),
                              ),
                              suffixIcon: IconButton(
                                tooltip: _obscurePassword
                                    ? 'Show password'
                                    : 'Hide password',
                                onPressed: isLoading
                                    ? null
                                    : _togglePasswordVisibility,
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                      child: CustomButton(
                        title: 'Continue',
                        textColor: Colors.white,
                        onPress: _submitLogin,
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
