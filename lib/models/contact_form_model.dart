class ContactFormModel {
  final String name;
  final String email;
  final String subject;
  final String message;

  const ContactFormModel({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
      };
}
