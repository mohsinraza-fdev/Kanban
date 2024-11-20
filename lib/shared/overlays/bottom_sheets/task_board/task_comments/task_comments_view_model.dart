import 'dart:async';

import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_comment.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/task_board_repo.dart';
import 'package:kanban_app/network/exceptions/cancelled_request_exception.dart';

class TaskCommentsViewModel extends CoreViewModel {
  final String taskId;
  final String projectId;
  TaskCommentsViewModel({
    required this.taskId,
    required this.projectId,
  });

  final _taskBoardRepo = locator<TaskBoardRepo>();

  List<TaskComment> _comments = [];
  List<TaskComment> get comments => _comments;

  late final controller = getTextEditingController();
  late final focusNode = getFocusNode();

  // Fetch
  bool failedFetchingComments = false;
  bool _isBusyFetchingComments = false;
  bool get isBusyFetchingComments => _isBusyFetchingComments;
  setBusyFetchingComments(bool value) {
    _isBusyFetchingComments = value;
    notifyListeners();
  }

  fetchComments() async {
    if (isBusyFetchingComments) return;
    failedFetchingComments = false;
    setBusyFetchingComments(true);
    try {
      _comments = await _taskBoardRepo.fetchComments(
        taskId: taskId,
      );
      _comments.sort((a, b) => b.postedAt.compareTo(a.postedAt));
    } catch (e) {
      if (e is! CancelledRequestException) {
        failedFetchingComments = true;
        setBusyFetchingComments(false);
        rethrow;
      }
    }
    setBusyFetchingComments(false);
  }

  //Create
  bool _isBusyCreatingComment = false;
  bool get isBusyCreatingComment => _isBusyCreatingComment;
  setBusyCreatingComment(bool value) {
    _isBusyCreatingComment = value;
    notifyListeners();
  }

  createComment() async {
    if (isBusyCreatingComment || controller.text.isEmpty) return;
    setBusyCreatingComment(true);
    try {
      final comment = await _taskBoardRepo.createComment(
        taskId: taskId,
        content: controller.text,
      );
      _comments.add(comment);
      _comments.sort((a, b) => b.postedAt.compareTo(a.postedAt));
      controller.clear();
    } catch (e) {
      if (e is! CancelledRequestException) {
        setBusyCreatingComment(false);
        rethrow;
      }
    }
    setBusyCreatingComment(false);
  }

  @override
  FutureOr<void> initialise() {
    fetchComments();
    return super.initialise();
  }
}
