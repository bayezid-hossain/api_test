class Message{
  final String id;
  final String fromAddress;
  final String fromName;
  final String toAddress;

  final String toName;
  final String subject;
  final String intro;
  final String text;
  final String date;
  Message({required this.id,required this.fromAddress,required this.toAddress,required this.fromName,required this.toName, required this.subject,required this.intro,required this.text,required this.date});

}