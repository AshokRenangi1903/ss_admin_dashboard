import 'package:ss_admin_dashboard/core/constants/app_urls.dart';
import 'package:ss_admin_dashboard/core/network/base_api_services.dart';
import 'package:ss_admin_dashboard/core/network/network_api_services.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';

class StoryBlockRepository {
  final BaseApiServices _api = NetworkApiServices();

  // Upload an image for a story block
  Future<String> uploadImage(List<int> bytes, String filename) async {
    final response = await _api.uploadImage(
      AppUrls.uploadImage,
      bytes: bytes,
      filename: filename,
    );

    return response['data']['imageUrl'] as String;
  }

  // Get all story Blocks of a story
  Future<List<StoryBlockModel>> getStoryBlocks(String storyId) async {
    final response = await _api.getApi(AppUrls.getStoryBlocks(storyId));
    final List<dynamic> data = response['data'];

    final List<StoryBlockModel> storyBlocksList = data
        .map((item) => StoryBlockModel.fromJson(item))
        .toList();

    return storyBlocksList;
  }

  // Create a Story Block
  Future<StoryBlockModel> createStoryBlock(
    StoryBlockModel block,
    String storyId,
  ) async {
    final response = await _api.postApi(
      AppUrls.createStoryBlock(storyId),
      data: block.toJson(),
    );
    return StoryBlockModel.fromJson(response['data']);
  }

  // Update a Story Block
  Future<StoryBlockModel> updateStoryBlock(
    StoryBlockModel block,
    String storyBlockId,
  ) async {
    final response = await _api.putApi(
      block.toJson(),

      AppUrls.updateStoryBlock(storyBlockId),
    );

    return StoryBlockModel.fromJson(response['data']);
  }

  // Delete a Story Block
  Future<void> deleteStoryBlock(String storyBlockId) async {
    await _api.deleteApi(AppUrls.deleteStoryBlock(storyBlockId));
  }

  // Reorder Story Blocks
  Future<dynamic> reorderStoryBlocks(
    List<String> orderedIds,
    String storyId,
  ) async {
    final response = await _api.patchApi({
      "orderedIds": orderedIds,
    }, AppUrls.reorderStoryBlocks(storyId));

    return response;
  }
}
