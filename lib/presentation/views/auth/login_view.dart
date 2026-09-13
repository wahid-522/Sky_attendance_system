import 'package:flutter/material.dart';
import 'package:sky_attendance/core/constants/app_strings.dart';
import 'package:sky_attendance/core/routes/app_routes.dart';
import 'package:sky_attendance/core/theme/app_colors.dart';
import 'package:sky_attendance/core/widgets/app_text_field.dart';
import 'package:sky_attendance/presentation/viewmodels/login_viewmodel.dart';
import 'package:sky_attendance/presentation/widgets/primary_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = LoginViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    _viewModel.login(
      onSuccess: () {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      },
      onError: (message) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red.shade700,
          ),
        );
      },
    );
  }

  void _onForgotPasswordPressed() {
    _viewModel.forgotPassword(
      onAction: (message) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: AppColors.buttonNavy,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400.0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(28.0, 38.0, 28.0, 32.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1.0,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x080F172A),
                          blurRadius: 12.0,
                          offset: Offset(0, 4),
                        ),
                        BoxShadow(
                          color: Color(0x140284C7),
                          blurRadius: 28.0,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Badge Icon
                        Container(
                          width: 64.0,
                          height: 64.0,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFE0F2FE), Color(0xFFBAE6FD)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(
                              color: const Color(0xFFBAE6FD),
                              width: 1.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x150284C7),
                                blurRadius: 12.0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.school_rounded,
                            size: 32.0,
                            color: AppColors.primarySkyBlue,
                          ),
                        ),
                        const SizedBox(height: 20.0),

                        // Academy Name
                        const Text(
                          AppStrings.academyTitleLine1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'serif',
                            fontSize: 19.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryNavy,
                            letterSpacing: 1.3,
                            height: 1.15,
                          ),
                        ),
                        const Text(
                          AppStrings.academyTitleLine2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'serif',
                            fontSize: 19.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryNavy,
                            letterSpacing: 1.3,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 8.0),

                        // Subtitle
                        const Text(
                          AppStrings.teacherPortalSubtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'serif',
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.subtitleSlate,
                          ),
                        ),
                        const SizedBox(height: 26.0),

                        // Email or Username Field
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppStrings.emailOrUsernameLabel,
                            style: const TextStyle(
                              fontFamily: 'serif',
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.labelText,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        AppTextField(
                          controller: _viewModel.emailController,
                          hintText: AppStrings.emailPlaceholder,
                          prefixIcon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16.0),

                        // Password Field & Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              AppStrings.passwordLabel,
                              style: TextStyle(
                                fontFamily: 'serif',
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: AppColors.labelText,
                              ),
                            ),
                            GestureDetector(
                              onTap: _onForgotPasswordPressed,
                              child: const Text(
                                AppStrings.forgotPassword,
                                style: TextStyle(
                                  fontFamily: 'serif',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.linkText,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        AppTextField(
                          controller: _viewModel.passwordController,
                          hintText: AppStrings.passwordPlaceholder,
                          prefixIcon: Icons.lock_outline_rounded,
                          obscureText: _viewModel.obscurePassword,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _onLoginPressed(),
                        ),
                        const SizedBox(height: 22.0),

                        // Login Button
                        PrimaryButton(
                          text: AppStrings.loginButtonText,
                          isLoading: _viewModel.isLoading,
                          onPressed: _onLoginPressed,
                        ),
                        const SizedBox(height: 32.0),

                        // Footer Note
                        const Text(
                          AppStrings.protectedNotice,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'serif',
                            fontSize: 11.5,
                            fontWeight: FontWeight.w400,
                            color: AppColors.footerText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
