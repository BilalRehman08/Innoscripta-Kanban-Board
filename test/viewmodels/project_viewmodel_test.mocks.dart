// Mocks generated by Mockito 5.4.4 from annotations
// in kanban_board_innoscripta/test/viewmodels/project_viewmodel_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:ui' as _i11;

import 'package:flutter/material.dart' as _i8;
import 'package:kanban_board_innoscripta/models/comment_model.dart' as _i4;
import 'package:kanban_board_innoscripta/models/project_model.dart' as _i2;
import 'package:kanban_board_innoscripta/models/task_model.dart' as _i3;
import 'package:kanban_board_innoscripta/repositories/api_repositories.dart'
    as _i12;
import 'package:kanban_board_innoscripta/services/projects_service.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i10;
import 'package:stacked_services/src/snackbar/snackbar_config.dart' as _i7;
import 'package:stacked_services/stacked_services.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeProjectModel_0 extends _i1.SmartFake implements _i2.ProjectModel {
  _FakeProjectModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTaskModel_1 extends _i1.SmartFake implements _i3.TaskModel {
  _FakeTaskModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCommentModel_2 extends _i1.SmartFake implements _i4.CommentModel {
  _FakeCommentModel_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProjectsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockProjectsService extends _i1.Mock implements _i5.ProjectsService {
  MockProjectsService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i2.ProjectModel> get projects => (super.noSuchMethod(
        Invocation.getter(#projects),
        returnValue: <_i2.ProjectModel>[],
      ) as List<_i2.ProjectModel>);

  @override
  set projects(List<_i2.ProjectModel>? _projects) => super.noSuchMethod(
        Invocation.setter(
          #projects,
          _projects,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set selectedProject(_i2.ProjectModel? _selectedProject) => super.noSuchMethod(
        Invocation.setter(
          #selectedProject,
          _selectedProject,
        ),
        returnValueForMissingStub: null,
      );

  @override
  void deleteProject(String? projectId) => super.noSuchMethod(
        Invocation.method(
          #deleteProject,
          [projectId],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void toggleFavorite(String? projectId) => super.noSuchMethod(
        Invocation.method(
          #toggleFavorite,
          [projectId],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void updateProject(_i2.ProjectModel? updatedProject) => super.noSuchMethod(
        Invocation.method(
          #updateProject,
          [updatedProject],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [SnackbarService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSnackbarService extends _i1.Mock implements _i6.SnackbarService {
  MockSnackbarService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isSnackbarOpen => (super.noSuchMethod(
        Invocation.getter(#isSnackbarOpen),
        returnValue: false,
      ) as bool);

  @override
  void registerSnackbarConfig(_i7.SnackbarConfig? config) => super.noSuchMethod(
        Invocation.method(
          #registerSnackbarConfig,
          [config],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerCustomMainButtonBuilder({
    dynamic variant,
    _i8.Widget Function(
      String?,
      Function?,
    )? builder,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerCustomMainButtonBuilder,
          [],
          {
            #variant: variant,
            #builder: builder,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerCustomSnackbarConfig({
    required dynamic variant,
    _i7.SnackbarConfig? config,
    _i7.SnackbarConfig Function()? configBuilder,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerCustomSnackbarConfig,
          [],
          {
            #variant: variant,
            #config: config,
            #configBuilder: configBuilder,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  void showSnackbar({
    String? title = r'',
    required String? message,
    dynamic Function(dynamic)? onTap,
    Duration? duration,
    String? mainButtonTitle,
    void Function()? onMainButtonTapped,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #showSnackbar,
          [],
          {
            #title: title,
            #message: message,
            #onTap: onTap,
            #duration: duration,
            #mainButtonTitle: mainButtonTitle,
            #onMainButtonTapped: onMainButtonTapped,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i9.Future<dynamic>? showCustomSnackBar({
    required String? message,
    _i8.TextStyle? messageTextStyle,
    required dynamic variant,
    String? title,
    _i8.TextStyle? titleTextStyle,
    String? mainButtonTitle,
    _i8.ButtonStyle? mainButtonStyle,
    void Function()? onMainButtonTapped,
    Function? onTap,
    Duration? duration,
  }) =>
      (super.noSuchMethod(Invocation.method(
        #showCustomSnackBar,
        [],
        {
          #message: message,
          #messageTextStyle: messageTextStyle,
          #variant: variant,
          #title: title,
          #titleTextStyle: titleTextStyle,
          #mainButtonTitle: mainButtonTitle,
          #mainButtonStyle: mainButtonStyle,
          #onMainButtonTapped: onMainButtonTapped,
          #onTap: onTap,
          #duration: duration,
        },
      )) as _i9.Future<dynamic>?);

  @override
  _i9.Future<void> closeSnackbar() => (super.noSuchMethod(
        Invocation.method(
          #closeSnackbar,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
}

/// A class which mocks [NavigationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigationService extends _i1.Mock implements _i6.NavigationService {
  MockNavigationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get previousRoute => (super.noSuchMethod(
        Invocation.getter(#previousRoute),
        returnValue: _i10.dummyValue<String>(
          this,
          Invocation.getter(#previousRoute),
        ),
      ) as String);

  @override
  String get currentRoute => (super.noSuchMethod(
        Invocation.getter(#currentRoute),
        returnValue: _i10.dummyValue<String>(
          this,
          Invocation.getter(#currentRoute),
        ),
      ) as String);

  @override
  _i8.GlobalKey<_i8.NavigatorState>? nestedNavigationKey(int? index) =>
      (super.noSuchMethod(Invocation.method(
        #nestedNavigationKey,
        [index],
      )) as _i8.GlobalKey<_i8.NavigatorState>?);

  @override
  void config({
    bool? enableLog,
    bool? defaultPopGesture,
    bool? defaultOpaqueRoute,
    Duration? defaultDurationTransition,
    bool? defaultGlobalState,
    _i6.Transition? defaultTransitionStyle,
    String? defaultTransition,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #config,
          [],
          {
            #enableLog: enableLog,
            #defaultPopGesture: defaultPopGesture,
            #defaultOpaqueRoute: defaultOpaqueRoute,
            #defaultDurationTransition: defaultDurationTransition,
            #defaultGlobalState: defaultGlobalState,
            #defaultTransitionStyle: defaultTransitionStyle,
            #defaultTransition: defaultTransition,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i9.Future<T?>? navigateWithTransition<T>(
    _i8.Widget? page, {
    bool? opaque,
    String? transition = r'',
    Duration? duration,
    bool? popGesture,
    int? id,
    _i8.Curve? curve,
    bool? fullscreenDialog = false,
    bool? preventDuplicates = true,
    _i6.Transition? transitionClass,
    _i6.Transition? transitionStyle,
    String? routeName,
  }) =>
      (super.noSuchMethod(Invocation.method(
        #navigateWithTransition,
        [page],
        {
          #opaque: opaque,
          #transition: transition,
          #duration: duration,
          #popGesture: popGesture,
          #id: id,
          #curve: curve,
          #fullscreenDialog: fullscreenDialog,
          #preventDuplicates: preventDuplicates,
          #transitionClass: transitionClass,
          #transitionStyle: transitionStyle,
          #routeName: routeName,
        },
      )) as _i9.Future<T?>?);

  @override
  _i9.Future<T?>? replaceWithTransition<T>(
    _i8.Widget? page, {
    bool? opaque,
    String? transition = r'',
    Duration? duration,
    bool? popGesture,
    int? id,
    _i8.Curve? curve,
    bool? fullscreenDialog = false,
    bool? preventDuplicates = true,
    _i6.Transition? transitionClass,
    _i6.Transition? transitionStyle,
    String? routeName,
  }) =>
      (super.noSuchMethod(Invocation.method(
        #replaceWithTransition,
        [page],
        {
          #opaque: opaque,
          #transition: transition,
          #duration: duration,
          #popGesture: popGesture,
          #id: id,
          #curve: curve,
          #fullscreenDialog: fullscreenDialog,
          #preventDuplicates: preventDuplicates,
          #transitionClass: transitionClass,
          #transitionStyle: transitionStyle,
          #routeName: routeName,
        },
      )) as _i9.Future<T?>?);

  @override
  bool back<T>({
    dynamic result,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #back,
          [],
          {
            #result: result,
            #id: id,
          },
        ),
        returnValue: false,
      ) as bool);

  @override
  void popUntil(
    _i8.RoutePredicate? predicate, {
    int? id,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #popUntil,
          [predicate],
          {#id: id},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void popRepeated(int? popTimes) => super.noSuchMethod(
        Invocation.method(
          #popRepeated,
          [popTimes],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i9.Future<T?>? navigateTo<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
    _i8.RouteTransitionsBuilder? transition,
  }) =>
      (super.noSuchMethod(Invocation.method(
        #navigateTo,
        [routeName],
        {
          #arguments: arguments,
          #id: id,
          #preventDuplicates: preventDuplicates,
          #parameters: parameters,
          #transition: transition,
        },
      )) as _i9.Future<T?>?);

  @override
  _i9.Future<T?>? navigateToView<T>(
    _i8.Widget? view, {
    dynamic arguments,
    int? id,
    bool? opaque,
    _i8.Curve? curve,
    Duration? duration,
    bool? fullscreenDialog = false,
    bool? popGesture,
    bool? preventDuplicates = true,
    _i6.Transition? transition,
    _i6.Transition? transitionStyle,
  }) =>
      (super.noSuchMethod(Invocation.method(
        #navigateToView,
        [view],
        {
          #arguments: arguments,
          #id: id,
          #opaque: opaque,
          #curve: curve,
          #duration: duration,
          #fullscreenDialog: fullscreenDialog,
          #popGesture: popGesture,
          #preventDuplicates: preventDuplicates,
          #transition: transition,
          #transitionStyle: transitionStyle,
        },
      )) as _i9.Future<T?>?);

  @override
  _i9.Future<T?>? replaceWith<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
    _i8.RouteTransitionsBuilder? transition,
  }) =>
      (super.noSuchMethod(Invocation.method(
        #replaceWith,
        [routeName],
        {
          #arguments: arguments,
          #id: id,
          #preventDuplicates: preventDuplicates,
          #parameters: parameters,
          #transition: transition,
        },
      )) as _i9.Future<T?>?);

  @override
  _i9.Future<T?>? clearStackAndShow<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) =>
      (super.noSuchMethod(Invocation.method(
        #clearStackAndShow,
        [routeName],
        {
          #arguments: arguments,
          #id: id,
          #parameters: parameters,
        },
      )) as _i9.Future<T?>?);

  @override
  _i9.Future<T?>? clearStackAndShowView<T>(
    _i8.Widget? view, {
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(Invocation.method(
        #clearStackAndShowView,
        [view],
        {
          #arguments: arguments,
          #id: id,
        },
      )) as _i9.Future<T?>?);

  @override
  _i9.Future<T?>? clearTillFirstAndShow<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
  }) =>
      (super.noSuchMethod(Invocation.method(
        #clearTillFirstAndShow,
        [routeName],
        {
          #arguments: arguments,
          #id: id,
          #preventDuplicates: preventDuplicates,
          #parameters: parameters,
        },
      )) as _i9.Future<T?>?);

  @override
  _i9.Future<T?>? clearTillFirstAndShowView<T>(
    _i8.Widget? view, {
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(Invocation.method(
        #clearTillFirstAndShowView,
        [view],
        {
          #arguments: arguments,
          #id: id,
        },
      )) as _i9.Future<T?>?);

  @override
  _i9.Future<T?>? pushNamedAndRemoveUntil<T>(
    String? routeName, {
    _i8.RoutePredicate? predicate,
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(Invocation.method(
        #pushNamedAndRemoveUntil,
        [routeName],
        {
          #predicate: predicate,
          #arguments: arguments,
          #id: id,
        },
      )) as _i9.Future<T?>?);
}

/// A class which mocks [DialogService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDialogService extends _i1.Mock implements _i6.DialogService {
  MockDialogService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void registerCustomDialogBuilders(
          Map<dynamic, _i6.DialogBuilder>? builders) =>
      super.noSuchMethod(
        Invocation.method(
          #registerCustomDialogBuilders,
          [builders],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerCustomDialogBuilder({
    required dynamic variant,
    required _i8.Widget Function(
      _i8.BuildContext,
      _i6.DialogRequest<dynamic>,
      dynamic Function(_i6.DialogResponse<dynamic>),
    )? builder,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerCustomDialogBuilder,
          [],
          {
            #variant: variant,
            #builder: builder,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i9.Future<_i6.DialogResponse<dynamic>?> showDialog({
    String? title,
    String? description,
    String? cancelTitle,
    _i11.Color? cancelTitleColor,
    String? buttonTitle = r'Ok',
    _i11.Color? buttonTitleColor,
    bool? barrierDismissible = false,
    _i6.DialogPlatform? dialogPlatform,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showDialog,
          [],
          {
            #title: title,
            #description: description,
            #cancelTitle: cancelTitle,
            #cancelTitleColor: cancelTitleColor,
            #buttonTitle: buttonTitle,
            #buttonTitleColor: buttonTitleColor,
            #barrierDismissible: barrierDismissible,
            #dialogPlatform: dialogPlatform,
          },
        ),
        returnValue: _i9.Future<_i6.DialogResponse<dynamic>?>.value(),
      ) as _i9.Future<_i6.DialogResponse<dynamic>?>);

  @override
  _i9.Future<_i6.DialogResponse<T>?> showCustomDialog<T, R>({
    dynamic variant,
    String? title,
    String? description,
    bool? hasImage = false,
    String? imageUrl,
    bool? showIconInMainButton = false,
    String? mainButtonTitle,
    bool? showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool? showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool? takesInput = false,
    _i11.Color? barrierColor = const _i11.Color(2315255808),
    bool? barrierDismissible = false,
    String? barrierLabel = r'',
    bool? useSafeArea = true,
    dynamic customData,
    R? data,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showCustomDialog,
          [],
          {
            #variant: variant,
            #title: title,
            #description: description,
            #hasImage: hasImage,
            #imageUrl: imageUrl,
            #showIconInMainButton: showIconInMainButton,
            #mainButtonTitle: mainButtonTitle,
            #showIconInSecondaryButton: showIconInSecondaryButton,
            #secondaryButtonTitle: secondaryButtonTitle,
            #showIconInAdditionalButton: showIconInAdditionalButton,
            #additionalButtonTitle: additionalButtonTitle,
            #takesInput: takesInput,
            #barrierColor: barrierColor,
            #barrierDismissible: barrierDismissible,
            #barrierLabel: barrierLabel,
            #useSafeArea: useSafeArea,
            #customData: customData,
            #data: data,
          },
        ),
        returnValue: _i9.Future<_i6.DialogResponse<T>?>.value(),
      ) as _i9.Future<_i6.DialogResponse<T>?>);

  @override
  _i9.Future<_i6.DialogResponse<dynamic>?> showConfirmationDialog({
    String? title,
    String? description,
    String? cancelTitle = r'Cancel',
    _i11.Color? cancelTitleColor,
    String? confirmationTitle = r'Ok',
    _i11.Color? confirmationTitleColor,
    bool? barrierDismissible = false,
    _i6.DialogPlatform? dialogPlatform,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showConfirmationDialog,
          [],
          {
            #title: title,
            #description: description,
            #cancelTitle: cancelTitle,
            #cancelTitleColor: cancelTitleColor,
            #confirmationTitle: confirmationTitle,
            #confirmationTitleColor: confirmationTitleColor,
            #barrierDismissible: barrierDismissible,
            #dialogPlatform: dialogPlatform,
          },
        ),
        returnValue: _i9.Future<_i6.DialogResponse<dynamic>?>.value(),
      ) as _i9.Future<_i6.DialogResponse<dynamic>?>);

  @override
  void completeDialog(_i6.DialogResponse<dynamic>? response) =>
      super.noSuchMethod(
        Invocation.method(
          #completeDialog,
          [response],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [ApiRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiRepository extends _i1.Mock implements _i12.ApiRepository {
  MockApiRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<List<_i2.ProjectModel>> getProjects() => (super.noSuchMethod(
        Invocation.method(
          #getProjects,
          [],
        ),
        returnValue:
            _i9.Future<List<_i2.ProjectModel>>.value(<_i2.ProjectModel>[]),
      ) as _i9.Future<List<_i2.ProjectModel>>);

  @override
  _i9.Future<void> deleteProject(String? projectId) => (super.noSuchMethod(
        Invocation.method(
          #deleteProject,
          [projectId],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<_i2.ProjectModel> createProject(_i2.ProjectModel? project) =>
      (super.noSuchMethod(
        Invocation.method(
          #createProject,
          [project],
        ),
        returnValue: _i9.Future<_i2.ProjectModel>.value(_FakeProjectModel_0(
          this,
          Invocation.method(
            #createProject,
            [project],
          ),
        )),
      ) as _i9.Future<_i2.ProjectModel>);

  @override
  _i9.Future<_i2.ProjectModel> updateProject(_i2.ProjectModel? project) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateProject,
          [project],
        ),
        returnValue: _i9.Future<_i2.ProjectModel>.value(_FakeProjectModel_0(
          this,
          Invocation.method(
            #updateProject,
            [project],
          ),
        )),
      ) as _i9.Future<_i2.ProjectModel>);

  @override
  _i9.Future<_i2.ProjectModel> getProject(String? projectId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProject,
          [projectId],
        ),
        returnValue: _i9.Future<_i2.ProjectModel>.value(_FakeProjectModel_0(
          this,
          Invocation.method(
            #getProject,
            [projectId],
          ),
        )),
      ) as _i9.Future<_i2.ProjectModel>);

  @override
  _i9.Future<List<_i3.TaskModel>> getTasks(String? projectId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTasks,
          [projectId],
        ),
        returnValue: _i9.Future<List<_i3.TaskModel>>.value(<_i3.TaskModel>[]),
      ) as _i9.Future<List<_i3.TaskModel>>);

  @override
  _i9.Future<_i3.TaskModel> getTask(String? taskId) => (super.noSuchMethod(
        Invocation.method(
          #getTask,
          [taskId],
        ),
        returnValue: _i9.Future<_i3.TaskModel>.value(_FakeTaskModel_1(
          this,
          Invocation.method(
            #getTask,
            [taskId],
          ),
        )),
      ) as _i9.Future<_i3.TaskModel>);

  @override
  _i9.Future<_i3.TaskModel> createTask(_i3.TaskModel? task) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTask,
          [task],
        ),
        returnValue: _i9.Future<_i3.TaskModel>.value(_FakeTaskModel_1(
          this,
          Invocation.method(
            #createTask,
            [task],
          ),
        )),
      ) as _i9.Future<_i3.TaskModel>);

  @override
  _i9.Future<_i3.TaskModel> updateTask(
    String? taskId,
    _i3.TaskModel? task,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTask,
          [
            taskId,
            task,
          ],
        ),
        returnValue: _i9.Future<_i3.TaskModel>.value(_FakeTaskModel_1(
          this,
          Invocation.method(
            #updateTask,
            [
              taskId,
              task,
            ],
          ),
        )),
      ) as _i9.Future<_i3.TaskModel>);

  @override
  _i9.Future<void> deleteTask(String? taskId) => (super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [taskId],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<List<_i4.CommentModel>> getComments(String? taskId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getComments,
          [taskId],
        ),
        returnValue:
            _i9.Future<List<_i4.CommentModel>>.value(<_i4.CommentModel>[]),
      ) as _i9.Future<List<_i4.CommentModel>>);

  @override
  _i9.Future<_i4.CommentModel> addComment(
    String? taskId,
    String? content,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addComment,
          [
            taskId,
            content,
          ],
        ),
        returnValue: _i9.Future<_i4.CommentModel>.value(_FakeCommentModel_2(
          this,
          Invocation.method(
            #addComment,
            [
              taskId,
              content,
            ],
          ),
        )),
      ) as _i9.Future<_i4.CommentModel>);

  @override
  _i9.Future<void> updateComment(
    String? commentId,
    String? newContent,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateComment,
          [
            commentId,
            newContent,
          ],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> deleteComment(String? commentId) => (super.noSuchMethod(
        Invocation.method(
          #deleteComment,
          [commentId],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  _i9.Future<void> closeTask(String? taskId) => (super.noSuchMethod(
        Invocation.method(
          #closeTask,
          [taskId],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);
}