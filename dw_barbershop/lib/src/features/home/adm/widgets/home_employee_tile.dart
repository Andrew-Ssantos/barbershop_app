import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HomeEmployeeTile extends StatelessWidget {
  final imageNetwork = false;
  const HomeEmployeeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorsConstants.grey),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 1),
              image: DecorationImage(
                image: switch (imageNetwork) {
                  true => const NetworkImage('url'),
                  false => const AssetImage(ImageConstants.avatar),
                } as ImageProvider,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nome e Sobrenome',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12)),
                        onPressed: () {},
                        child: const Text('AGENDAR'),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12)),
                        onPressed: () {},
                        child: const Text('VER AGENDA'),
                      ),
                      const Icon(
                        BarbershopIcons.penEdit,
                        size: 16,
                        color: ColorsConstants.brow,
                      ),
                      const Icon(
                        BarbershopIcons.trash,
                        size: 16,
                        color: ColorsConstants.red,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
