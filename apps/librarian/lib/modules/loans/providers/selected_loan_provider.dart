import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:librarian_app/core/models/loan_model.dart';

final selectedLoanProvider = StateProvider<LoanModel?>((ref) => null);
