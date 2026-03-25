import 'package:bloc/bloc.dart';
import 'package:chat_bot/core/api/api_consumer.dart';
import 'package:chat_bot/core/error/api_error.dart';
import 'package:chat_bot/core/error/server_exception.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:chat_bot/core/api/api_endpoints.dart';

part 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final ApiConsumer apiConsumer;
  AiChatCubit( {required this.apiConsumer}) : super(AiChatInitial());

  Future<void> sendMessage(String prompt, {bool reasoning = false}) async {
    emit(AiChatLoading());

    try {
      final resp = await apiConsumer.post(
        EndPoints.chat,
        body: {
          "model": APIKeys.ai_model,
          "messages": [
            {"role": "user", "content": prompt},
          ],
          "reasoning_enabled": reasoning,
          "max_tokens": 100000,
        },
      );

      if (resp.data?["choices"] != null && resp.data!["choices"].isNotEmpty) {
        final content =
            resp.data!["choices"][0]["message"]["content"] as String;
        emit(AiChatSuccess(content.trim()));
      } else {
        throw ServerException(
          ApiError(
            statusCode: resp.statusCode,
            message: "No response from model.",
          ),
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final apiError = ApiError.fromJson(
          e.response?.data ?? {},
          statusCode: e.response?.statusCode,
        );
        emit(AiChatError(apiError.message));
      } else {
        emit(AiChatError("Network error: ${e.message}"));
      }
    } on ServerException catch (e) {
      emit(AiChatError(e.error.message));
    } catch (e) {
      emit(AiChatError("Unexpected error: $e"));
    }
  }
}
