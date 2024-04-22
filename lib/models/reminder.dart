import 'package:kurs_oop/services/services.dart';

abstract class Reminder {
  Reminder({required this.title});

  final String title;

  void triggerNotificaton();
}

class HighPriorityReminder extends Reminder {
  HighPriorityReminder({
    required super.title,
    required this.remindAt,
  });

  final DateTime remindAt;
  @override
  void triggerNotificaton() {
    NotificationService().showSceduledNotification(
      title: 'Дедлайн горит🔥🔥🔥',
      body:
          'Срок выполнения задачи "$title" скоро подойдет к концу, поскорее возьмитесь за ее выполнение',
      scheduledDate: remindAt,
    );
  }
}

class LowPriorityReminder extends Reminder {
  LowPriorityReminder({
    required super.title,
    required this.remindAt,
  });

  final DateTime remindAt;

  @override
  void triggerNotificaton() {
    NotificationService().showSceduledNotification(
      title: 'Дедлайн задачи',
      body:
          'Срок выполнения задачи скоро подойдет к концу, поскорее возьмитесь за ее выполнение',
      scheduledDate: remindAt,
    );
  }
}
