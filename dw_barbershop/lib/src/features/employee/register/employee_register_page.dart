import 'dart:developer';
import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_vm.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerADM = false;
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final barbershopAsyncValue = ref.watch(getMyBarbershopProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status), (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.sucess:
          Messages.showSuccess('Colaborador cadastrado com sucesso', context);
          Navigator.of(context).pop;
        case EmployeeRegisterStateStatus.error:
          Messages.showError('Erro ao registrar colaborador', context);
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar Colaborador'),
        ),
        body: barbershopAsyncValue.when(
          error: (error, stackTrace) {
            log('Erro ao carregar a página', error: error, stackTrace: stackTrace);
            return const Text('Erro ao carregar a página');
          },
          loading: () => const BarbershopLoader(),
          data: (barbershopModel) {
            final BarbershopModel(:openingDays, :openingHours) = barbershopModel;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  child: Center(
                    child: Column(
                      children: [
                        const AvatarWidget(),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Checkbox.adaptive(
                              value: registerADM,
                              onChanged: (value) {
                                setState(() {
                                  registerADM = !registerADM;
                                  employeeRegisterVm.setRegisterADM(registerADM);
                                });
                              },
                            ),
                            const Expanded(
                              child: Text(
                                'Sou o administrador e quero me cadastrar como colaborador',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Offstage(
                          offstage: registerADM,
                          child: Column(
                            children: [
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: nameEC,
                                validator: registerADM ? null : Validatorless.required('Nome obrigatório'),
                                decoration: const InputDecoration(label: Text('Nome')),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: emailEC,
                                validator: registerADM
                                    ? null
                                    : Validatorless.multiple([
                                        Validatorless.required('Nome obrigatório'),
                                        Validatorless.email('Email inválido'),
                                      ]),
                                decoration: const InputDecoration(label: Text('Email')),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                obscureText: true,
                                controller: passwordEC,
                                validator: registerADM
                                    ? null
                                    : Validatorless.multiple([
                                        Validatorless.required('Senha obrigátoria'),
                                        Validatorless.min(6, 'Senha deve conter pelo menos 6 caracteres'),
                                      ]),
                                decoration: const InputDecoration(label: Text('Senha')),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                        WeekdaysPanel(
                          enabledDays: openingDays,
                          onDayPressed: employeeRegisterVm.addOrRemoveWorkdays,
                        ),
                        const SizedBox(height: 24),
                        HoursPanel(
                          enabledTimes: openingHours,
                          startTime: 6,
                          endTime: 23,
                          onHourPressed: employeeRegisterVm.addOrRemoveWorkhours,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                          onPressed: () {
                            switch (formKey.currentState?.validate()) {
                              case false || null:
                                Messages.showError('Existem campos inválidos', context);
                              case true:
                                final EmployeeRegisterState(
                                  workdays: List(isNotEmpty: hasWorkDays),
                                  workhours: List(isNotEmpty: hasWorkHours),
                                ) = ref.watch(employeeRegisterVmProvider);

                                if (!hasWorkDays || !hasWorkHours) {
                                  Messages.showError(
                                      'Por favor selecione os dias da semana e horário de atendimento', context);
                                  return;
                                }

                                final name = nameEC.text;
                                final email = emailEC.text;
                                final password = passwordEC.text;
                                employeeRegisterVm.register(
                                  name: name,
                                  email: email,
                                  password: password,
                                );
                            }
                          },
                          child: const Text('CADASTRAR COLABORADOR'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
