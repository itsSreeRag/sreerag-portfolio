import 'package:flutter/material.dart';
import '../../../models/contact_form_model.dart';
import '../../../repositories/portfolio_repository.dart';

class ContactViewModel extends ChangeNotifier {
  final PortfolioRepository _repository;

  ContactViewModel({required PortfolioRepository repository})
      : _repository = repository;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> submitForm({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    _isSubmitting = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    try {
      final form = ContactFormModel(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );
      final success = await _repository.sendContactMessage(form);
      _isSubmitting = false;
      _isSuccess = success;
      notifyListeners();
      return success;
    } catch (e) {
      _isSubmitting = false;
      _errorMessage = 'Failed to send message. Please try again.';
      notifyListeners();
      return false;
    }
  }

  void resetStatus() {
    _isSuccess = false;
    _errorMessage = null;
    notifyListeners();
  }
}
