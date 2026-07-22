class ContactFormModel {
  final String name;
  final String email;
  final String? phone;
  final String subject;
  final String message;

  const ContactFormModel({
    required this.name,
    required this.email,
    this.phone,
    required this.subject,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'subject': subject,
        'message': message,
      };
}

