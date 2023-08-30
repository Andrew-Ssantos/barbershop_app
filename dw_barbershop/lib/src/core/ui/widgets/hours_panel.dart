import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatelessWidget {
  final int startTime;
  final int endTime;

  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os horários de atendimento',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (int i = startTime; i <= endTime; i++)
              TimeButton(label: '${i.toString().padLeft(2, '0')}:00'),
          ],
        )
      ],
    );
  }
}

class TimeButton extends StatefulWidget {
  final String label;
  final int value;
  final ValueChanged<int> onPressed;

  const TimeButton({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selectd = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(color: ColorsConstants.grey),
      ),
      child: Center(
          child: Text(
        widget.label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: ColorsConstants.grey,
        ),
      )),
    );
  }
}
