import 'package:medical_app/features/lab-test/data/models/lab_test_model.dart';

class LabTestState {}

class LabTestInitial extends LabTestState {}

class LabTestLoading extends LabTestState {}

class LabTestLoaded extends LabTestState {
  final List<LabTestModel> labTests;
  final bool isOffline;

  LabTestLoaded(this.labTests, {this.isOffline = false});
}

class LabTestError extends LabTestState {
  final String message;

  LabTestError(this.message);
}
