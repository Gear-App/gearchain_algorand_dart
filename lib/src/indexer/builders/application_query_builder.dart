import '../../api/responses.dart';
import 'query_builders.dart';
import '../../repositories/repositories.dart';

class ApplicationQueryBuilder extends QueryBuilder<ApplicationQueryBuilder> {
  /// Reserved keyword to check balances
  static const KEY_BALANCE_ID = 'balance-asset-id';

  final IndexerRepository indexerRepository;

  ApplicationQueryBuilder({required this.indexerRepository});

  /// Application ID
  ApplicationQueryBuilder whereApplicationId(int applicationId) {
    addQueryParameter('application-id', applicationId);
    return this;
  }

  /// Perform the query and fetch the transactions.
  Future<SearchApplicationsResponse> search({int? limit}) async {
    if (limit != null) {
      this.limit(limit);
    }

    // Search the transactions
    return indexerRepository.searchApplications(parameters);
  }

  @override
  ApplicationQueryBuilder me() {
    return this;
  }
}
