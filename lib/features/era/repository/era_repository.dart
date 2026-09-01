import 'package:ss_admin_dashboard/core/constants/app_urls.dart';
import 'package:ss_admin_dashboard/core/network/base_api_services.dart';
import 'package:ss_admin_dashboard/core/network/network_api_services.dart';
import 'package:ss_admin_dashboard/features/era/model/era_model.dart';

class EraRepository {
  final BaseApiServices _api = NetworkApiServices();

  // Get All Era
  Future<List<EraModel>> getAllEras() async {
    final response = await _api.getApi(AppUrls.getAllEras);
    final List<dynamic> data = response['data'];

    final List<EraModel> erasList = data
        .map((item) => EraModel.fromJson(item))
        .toList();

    return erasList;
  }

  // Create New Era
  Future<EraModel> createEra(EraModel era) async {
    final response = await _api.postApi(
      
      AppUrls.createEra,
      data: era.toJson(),
    );
    return EraModel.fromJson(response['data']);
  }

  // Update an Era
  Future<EraModel> updateEra(String id, EraModel era) async {
    final response = await _api.putApi(
      era.toJson(),
      AppUrls.updateEra(id),
    );

    return EraModel.fromJson(response['data']);
  }

  // Delete an Era
  Future<void> deleteEra(String id) async {
    await _api.deleteApi(AppUrls.deleteEra(id));
  }
}
