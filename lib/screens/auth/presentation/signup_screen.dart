import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bdcomputing/models/common/country.dart';
import 'package:bdcomputing/models/enums/industry_enum.dart';
import 'package:bdcomputing/screens/auth/domain/client_registration_model.dart';
import 'package:bdcomputing/components/shared/section_card.dart';
import 'package:bdcomputing/components/shared/custom_text_field.dart';
import 'package:bdcomputing/components/shared/custom_button.dart';
import 'package:bdcomputing/components/shared/country_picker_field.dart';
import 'package:bdcomputing/screens/auth/auth_provider.dart';
import 'package:bdcomputing/core/styles.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Personal Information
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  // Account Type
  bool _isCorporate = false;

  // Tax & Business Information
  final _kraPINCtrl = TextEditingController();
  final _idNumberCtrl = TextEditingController();
  final _incorporationNumberCtrl = TextEditingController();
  Industry? _selectedIndustry;

  // Address
  final _streetCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _stateCtrl = TextEditingController();
  final _zipCodeCtrl = TextEditingController();
  Country? _selectedCountry;

  // Security
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  bool _submitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _kraPINCtrl.dispose();
    _idNumberCtrl.dispose();
    _incorporationNumberCtrl.dispose();
    _streetCtrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    _zipCodeCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // Validate country selection
    if (_selectedCountry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select your country'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    // Validate industry selection
    if (_selectedIndustry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select your industry'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    // Validate password match
    if (_passwordCtrl.text != _confirmPasswordCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Passwords do not match'),
          backgroundColor: Colors.red[800],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      final service = ref.read(authServiceProvider);

      final registration = ClientRegistration(
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        kraPIN: _kraPINCtrl.text.trim().isEmpty ? null : _kraPINCtrl.text.trim(),
        idNumber: _idNumberCtrl.text.trim().isEmpty ? null : _idNumberCtrl.text.trim(),
        incorporationNumber: _incorporationNumberCtrl.text.trim().isEmpty 
            ? null 
            : _incorporationNumberCtrl.text.trim(),
        industry: _selectedIndustry!,
        countryId: _selectedCountry!.id,
        city: _cityCtrl.text.trim(),
        state: _stateCtrl.text.trim(),
        street: _streetCtrl.text.trim(),
        zipCode: _zipCodeCtrl.text.trim(),
        isCorporate: _isCorporate,
        password: _passwordCtrl.text,
      );

      await service.signup(registration);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Account created successfully! Please log in.'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(child: Text(e.toString())),
            ],
          ),
          backgroundColor: Colors.red[800],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
    final isLoading = _submitting || state is AuthLoading;

    // Responsive: get screen width
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final isSmall = width < 400;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Header Section
            Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary600,
                    AppColors.primary700,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -20,
                    left: -20,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    right: -30,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (Navigator.canPop(context))
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white.withValues(alpha: 0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          const Spacer(),
                          const Text(
                            'Client Registration',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Join BD Work OS and start managing your business today.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 15,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Form Section
            Transform.translate(
              offset: const Offset(0, -30),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmall ? 12.0 : 20.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Personal Information
                          SectionCard(
                            title: 'Personal Information',
                            children: [
                              CustomTextField(
                                label: 'Full Name',
                                controller: _nameCtrl,
                                hintText: 'e.g., John Doe',
                                prefixIcon: Icons.person_outline,
                                isRequired: true,
                                validator: (v) => (v == null || v.isEmpty)
                                    ? 'Full name is required'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                label: 'Email Address',
                                controller: _emailCtrl,
                                hintText: 'e.g., john@example.com',
                                prefixIcon: Icons.email_outlined,
                                isRequired: true,
                                keyboardType: TextInputType.emailAddress,
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Email is required';
                                  }
                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                label: 'Phone Number',
                                controller: _phoneCtrl,
                                hintText: 'e.g., 0719155083',
                                prefixIcon: Icons.phone_outlined,
                                isRequired: true,
                                keyboardType: TextInputType.phone,
                                validator: (v) => (v == null || v.isEmpty)
                                    ? 'Phone number is required'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              // Account Type
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        'Account Type',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '*',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.border),
                                      borderRadius: BorderRadius.circular(AppRadius.md),
                                    ),
                                    child: DropdownButtonFormField<bool>(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: false,
                                          child: Text('Individual'),
                                        ),
                                        DropdownMenuItem(
                                          value: true,
                                          child: Text('Corporate'),
                                        ),
                                      ],
                                      initialValue: _isCorporate,
                                      onChanged: isLoading
                                          ? null
                                          : (value) {
                                              setState(() {
                                                _isCorporate = value ?? false;
                                                // Clear conditional fields when switching
                                                _idNumberCtrl.clear();
                                                _incorporationNumberCtrl.clear();
                                              });
                                            },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Tax & Business Information
                          SectionCard(
                            title: 'Tax & Business Information',
                            children: [
                              if (_isCorporate)
                                CustomTextField(
                                  label: 'Incorporation Number',
                                  controller: _incorporationNumberCtrl,
                                  hintText: 'e.g., PVT-123456',
                                  prefixIcon: Icons.business_outlined,
                                  isRequired: false,
                                )
                              else
                                CustomTextField(
                                  label: 'ID Number',
                                  controller: _idNumberCtrl,
                                  hintText: 'e.g., 12345678',
                                  prefixIcon: Icons.badge_outlined,
                                  isRequired: false,
                                  keyboardType: TextInputType.number,
                                ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                label: 'KRA PIN',
                                controller: _kraPINCtrl,
                                hintText: 'e.g., A123456789X',
                                prefixIcon: Icons.receipt_long_outlined,
                                isRequired: false,
                              ),
                              const SizedBox(height: 16),
                              // Industry Dropdown
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        'Industry',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '*',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.border),
                                      borderRadius: BorderRadius.circular(AppRadius.md),
                                    ),
                                    child: DropdownButtonFormField<Industry>(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        hintText: 'Select Industry',
                                      ),
                                      items: Industry.values.map((industry) {
                                        return DropdownMenuItem(
                                          value: industry,
                                          child: Text(industry.displayName),
                                        );
                                      }).toList(),
                                      onChanged: isLoading
                                          ? null
                                          : (value) {
                                              setState(() {
                                                _selectedIndustry = value;
                                              });
                                            },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Address Information
                          SectionCard(
                            title: 'Address Information',
                            children: [
                              CountryPickerField(
                                selectedCountry: _selectedCountry,
                                onSelected: (c) =>
                                    setState(() => _selectedCountry = c),
                                isRequired: true,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                label: 'Street Address',
                                controller: _streetCtrl,
                                hintText: 'e.g., Ronald Ngala Street',
                                prefixIcon: Icons.location_on_outlined,
                                isRequired: true,
                                validator: (v) => (v == null || v.isEmpty)
                                    ? 'Street address is required'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      label: 'City/County',
                                      controller: _cityCtrl,
                                      hintText: 'e.g., Eldoret',
                                      prefixIcon: Icons.location_city_outlined,
                                      isRequired: true,
                                      validator: (v) => (v == null || v.isEmpty)
                                          ? 'City is required'
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: CustomTextField(
                                      label: 'State/Town',
                                      controller: _stateCtrl,
                                      hintText: 'e.g., Uasin Gishu',
                                      prefixIcon: Icons.map_outlined,
                                      isRequired: true,
                                      validator: (v) => (v == null || v.isEmpty)
                                          ? 'State is required'
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                label: 'Zip/Postal Code',
                                controller: _zipCodeCtrl,
                                hintText: 'e.g., 30100',
                                prefixIcon: Icons.markunread_mailbox_outlined,
                                isRequired: true,
                                validator: (v) => (v == null || v.isEmpty)
                                    ? 'Zip code is required'
                                    : null,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),

                          // Security Information
                          SectionCard(
                            title: 'Security Information',
                            children: [
                              CustomTextField(
                                label: 'Password',
                                controller: _passwordCtrl,
                                hintText: 'Create a strong password',
                                prefixIcon: Icons.lock_outline,
                                isPassword: true,
                                isRequired: true,
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Password is required';
                                  }
                                  if (v.length < 8) {
                                    return 'Password must be at least 8 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                label: 'Confirm Password',
                                controller: _confirmPasswordCtrl,
                                hintText: 'Re-enter your password',
                                prefixIcon: Icons.lock_outline,
                                isPassword: true,
                                isRequired: true,
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (v != _passwordCtrl.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          CustomButton(
                            text: 'Create Account',
                            onPressed: _submit,
                            isLoading: isLoading,
                          ),

                          const SizedBox(height: 24),

                          // Login redirect
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: isLoading
                                      ? null
                                      : () => Navigator.of(context).pop(),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
