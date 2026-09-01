import 'package:ss_admin_dashboard/core/constants/app_urls.dart';
import 'package:ss_admin_dashboard/core/network/base_api_services.dart';
import 'package:ss_admin_dashboard/core/network/network_api_services.dart';
import 'package:ss_admin_dashboard/features/story/model/story_model.dart';

class StoryRepository {
  final BaseApiServices _api = NetworkApiServices();

  // Get All the Stories
  Future<List<StoryModel>> getAllStories() async {
    final response = await _api.getApi(AppUrls.getAllStories);
    final List<dynamic> data = response['data'];

    final List<StoryModel> storiesList = data
        .map((item) => StoryModel.fromJson(item))
        .toList();

    return storiesList;
  }

  // Get Stories of an Era
  Future<List<StoryModel>> getEraStories(String eraId) async {
    final response = await _api.getApi(AppUrls.getEraStories(eraId));
    final List<dynamic> data = response['data'];

    final List<StoryModel> eraStoriesList = data
        .map((item) => StoryModel.fromJson(item))
        .toList();

    return eraStoriesList;
  }

  // Create a new Story
  Future<StoryModel> createStory(StoryModel story, String eraId) async {
    final response = await _api.postApi(
     
      AppUrls.createStory(eraId),
      data: story.toJson(),
    );

    return StoryModel.fromJson(response['data']);
  }

  // Update a Story
  Future<StoryModel> updateStory(StoryModel story, String storyId) async {
    final response = await _api.putApi(
      story.toJson(),
      
      AppUrls.updateStory(storyId),
    );

    return StoryModel.fromJson(response['data']);
  }

  // Delete a Story
  Future<void> deleteStory(String id) async {
    await _api.deleteApi( AppUrls.deleteStory(id));
  }

  // Reorder Stories of an Era
  Future<dynamic> reorderStories(List<String> orderedIds, String eraId) async {
    print("Repo orderIds $orderedIds");
    final response = await _api.patchApi(
      {"storyIds": orderedIds},

      AppUrls.reorderStories(eraId),
    );

    return response;
  }
}
