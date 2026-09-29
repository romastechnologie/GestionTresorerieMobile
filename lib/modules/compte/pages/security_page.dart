import 'package:expense_manager/config/colors.dart';
import 'package:flutter/material.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Traitement de la modification du mot de passe
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mot de passe mis à jour avec succès')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Sécurité du compte'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSecurityHeader(),
            const SizedBox(height: 24),
            _buildPasswordForm(),
            const SizedBox(height: 32),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.lock,
          size: 48,
          color: Colors.amber,
        ),
        const SizedBox(height: 16),
        Text(
          'Modification du mot de passe',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Pour la sécurité de votre compte, choisissez un mot de passe fort et unique.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildPasswordField(
            controller: _currentPasswordController,
            label: 'Mot de passe actuel',
            obscureText: _obscureCurrentPassword,
            onToggleVisibility: () => setState(() {
              _obscureCurrentPassword = !_obscureCurrentPassword;
            }),
          ),
          const SizedBox(height: 16),
          _buildPasswordField(
            controller: _newPasswordController,
            label: 'Nouveau mot de passe',
            obscureText: _obscureNewPassword,
            onToggleVisibility: () => setState(() {
              _obscureNewPassword = !_obscureNewPassword;
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un nouveau mot de passe';
              }
              if (value.length < 8) {
                return 'Le mot de passe doit contenir au moins 8 caractères';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildPasswordField(
            controller: _confirmPasswordController,
            label: 'Confirmer le nouveau mot de passe',
            obscureText: _obscureConfirmPassword,
            onToggleVisibility: () => setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            }),
            validator: (value) {
              if (value != _newPasswordController.text) {
                return 'Les mots de passe ne correspondent pas';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildPasswordRequirements(),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.primary,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.primary,
        )),
        labelText: label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.primary,
            )),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppColors.primary,
          ),
          onPressed: onToggleVisibility,
        ),
      ),
    );
  }

  Widget _buildPasswordRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Votre mot de passe doit contenir :',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
            const SizedBox(width: 8),
            Text('Minimum 8 caractères', style: TextStyle(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
            const SizedBox(width: 8),
            Text('Lettres majuscules et minuscules',
                style: TextStyle(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
            const SizedBox(width: 8),
            Text('Au moins un chiffre', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _submitForm,
        child: const Text(
          'ENREGISTRER',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
