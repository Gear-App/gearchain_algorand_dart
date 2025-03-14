import '../../api/responses.dart';
import 'query_builders.dart';
import '../../repositories/repositories.dart';

class AccountQueryBuilder extends QueryBuilder<AccountQueryBuilder> {
  /// Reserved keyword to check balances
  static const KEY_BALANCE_ID = 'balance-asset-id';

  final IndexerRepository indexerRepository;

  AccountQueryBuilder({required this.indexerRepository});

  /// Lookup the list of accounts who hold this asset
  AccountQueryBuilder balances(int assetId) {
    addQueryParameter(KEY_BALANCE_ID, assetId);
    return this;
  }

  /// Include results with the given application id.
  AccountQueryBuilder whereApplicationId(int applicationId) {
    addQueryParameter('application-id', applicationId);
    return this;
  }

  /// Include accounts configured to use this spending key.
  AccountQueryBuilder whereAuthAddress(String authAddress) {
    addQueryParameter('auth-addr', authAddress);
    return this;
  }

  /// Perform the query and fetch the transactions.
  Future<SearchAccountsResponse> search({int? limit}) async {
    if (limit != null) {
      this.limit(limit);
    }

    // Search the transactions
    return indexerRepository.searchAccounts(parameters);
  }

  @override
  AccountQueryBuilder me() {
    return this;
  }
}
