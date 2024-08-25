// Mocks generated by Mockito 5.4.4 from annotations
// in kanban_board_innoscripta/test/repositories/project_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dio/dio.dart' as _i2;
import 'package:flutter/material.dart' as _i6;
import 'package:kanban_board_innoscripta/services/api_service.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;

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

class _FakeDio_0 extends _i1.SmartFake implements _i2.Dio {
  _FakeDio_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_1<T> extends _i1.SmartFake implements _i2.Response<T> {
  _FakeResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiService extends _i1.Mock implements _i3.ApiService {
  MockApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Dio get dio => (super.noSuchMethod(
        Invocation.getter(#dio),
        returnValue: _FakeDio_0(
          this,
          Invocation.getter(#dio),
        ),
      ) as _i2.Dio);

  @override
  String get baseUrl => (super.noSuchMethod(
        Invocation.getter(#baseUrl),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#baseUrl),
        ),
      ) as String);

  @override
  String get token => (super.noSuchMethod(
        Invocation.getter(#token),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#token),
        ),
      ) as String);

  @override
  _i5.Future<_i2.Response<dynamic>> get(
    String? path, {
    Map<String, dynamic>? queryParameters,
    _i6.BuildContext? context,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [path],
          {
            #queryParameters: queryParameters,
            #context: context,
          },
        ),
        returnValue:
            _i5.Future<_i2.Response<dynamic>>.value(_FakeResponse_1<dynamic>(
          this,
          Invocation.method(
            #get,
            [path],
            {
              #queryParameters: queryParameters,
              #context: context,
            },
          ),
        )),
      ) as _i5.Future<_i2.Response<dynamic>>);

  @override
  _i5.Future<_i2.Response<dynamic>> post(
    String? path, {
    dynamic data,
    _i6.BuildContext? context,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [path],
          {
            #data: data,
            #context: context,
          },
        ),
        returnValue:
            _i5.Future<_i2.Response<dynamic>>.value(_FakeResponse_1<dynamic>(
          this,
          Invocation.method(
            #post,
            [path],
            {
              #data: data,
              #context: context,
            },
          ),
        )),
      ) as _i5.Future<_i2.Response<dynamic>>);

  @override
  _i5.Future<_i2.Response<dynamic>> put(
    String? path, {
    dynamic data,
    _i6.BuildContext? context,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [path],
          {
            #data: data,
            #context: context,
          },
        ),
        returnValue:
            _i5.Future<_i2.Response<dynamic>>.value(_FakeResponse_1<dynamic>(
          this,
          Invocation.method(
            #put,
            [path],
            {
              #data: data,
              #context: context,
            },
          ),
        )),
      ) as _i5.Future<_i2.Response<dynamic>>);

  @override
  _i5.Future<_i2.Response<dynamic>> delete(
    String? path, {
    _i6.BuildContext? context,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [path],
          {#context: context},
        ),
        returnValue:
            _i5.Future<_i2.Response<dynamic>>.value(_FakeResponse_1<dynamic>(
          this,
          Invocation.method(
            #delete,
            [path],
            {#context: context},
          ),
        )),
      ) as _i5.Future<_i2.Response<dynamic>>);

  @override
  void handleError(_i2.DioException? e) => super.noSuchMethod(
        Invocation.method(
          #handleError,
          [e],
        ),
        returnValueForMissingStub: null,
      );
}
