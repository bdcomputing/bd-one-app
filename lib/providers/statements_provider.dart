import 'package:bdoneapp/models/common/statement.dart';
import 'package:bdoneapp/models/common/paginated_data.dart';
import 'package:bdoneapp/providers/providers.dart';
import 'package:bdoneapp/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class StatementsState {
  final bool isLoading;
  final List<Statement> statements;
  final int page;
  final int totalPages;
  final String? error;

  StatementsState({
    this.isLoading = false,
    this.statements = const [],
    this.page = 1,
    this.totalPages = 1,
    this.error,
  });

  StatementsState copyWith({
    bool? isLoading,
    List<Statement>? statements,
    int? page,
    int? totalPages,
    String? error,
  }) {
    return StatementsState(
      isLoading: isLoading ?? this.isLoading,
      statements: statements ?? this.statements,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      error: error,
    );
  }
}

class StatementsNotifier extends StateNotifier<StatementsState> {
  final Ref _ref;

  StatementsNotifier(this._ref) : super(StatementsState()) {
    fetchStatements();
  }

  Future<void> fetchStatements({bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      state = state.copyWith(page: 1, statements: [], isLoading: true);
    } else {
      state = state.copyWith(isLoading: true);
    }

    try {
      final user = await _ref.read(authProvider.notifier).getCurrentUser();
      final clientId = user?.clientId;

      if (clientId == null) {
        state = state.copyWith(isLoading: false, error: 'No client associated with this account');
        return;
      }

      final service = _ref.read(statementsServiceProvider);
      final PaginatedData<Statement> result = await service.fetchStatements(
        clientId: clientId,
        page: state.page,
      );

      state = state.copyWith(
        isLoading: false,
        statements: refresh ? result.data : [...state.statements, ...(result.data ?? [])],
        totalPages: result.pages,
        page: state.page + 1,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() => fetchStatements(refresh: true);
}

final statementsProvider = StateNotifierProvider<StatementsNotifier, StatementsState>((ref) {
  return StatementsNotifier(ref);
});
