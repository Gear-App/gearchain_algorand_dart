import '../../api/responses.dart';
import 'query_builders.dart';
import '../../repositories/repositories.dart';

class AssetQueryBuilder extends QueryBuilder<AssetQueryBuilder> {
  final IndexerRepository indexerRepository;

  AssetQueryBuilder({required this.indexerRepository});

  /// Filter just assets with the given creator address.
  AssetQueryBuilder whereCreator(String creator) {
    addQueryParameter('creator', creator);
    return this;
  }

  /// Filter just assets with the given asset name.
  AssetQueryBuilder whereAssetName(String name) {
    addQueryParameter('name', name);
    return this;
  }

  /// Filter just assets with the given unit name.
  AssetQueryBuilder whereUnitName(String unitName) {
    addQueryParameter('unit', unitName);
    return this;
  }

  /// Perform the query and fetch the transactions.
  Future<SearchAssetsResponse> search({int? limit}) async {
    if (limit != null) {
      this.limit(limit);
    }

    // Search the transactions
    return indexerRepository.searchAssets(parameters);
  }

  @override
  AssetQueryBuilder me() {
    return this;
  }
}
