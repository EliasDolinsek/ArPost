// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'app/ar/ar_actions_bloc.dart';
import 'app/auth/auth_bloc.dart';
import 'app/comments/comments_bloc.dart';
import 'infrastructure/auth/firebase_auth_facade.dart';
import 'infrastructure/comments/firebase_comment_facade.dart';
import 'infrastructure/core/firebase_injectable_module.dart';
import 'domain/auth/i_auth_facade.dart';
import 'domain/comments/i_comment_facade.dart';
import 'domain/post/i_post_facade.dart';
import 'infrastructure/post/post_facade_default_impl.dart';
import 'app/post/posts_bloc.dart';
import 'app/auth/sign_in_form/sign_in_form_bloc.dart';
import 'infrastructure/post/upload_file_manager.dart';
import 'app/user_posts/user_posts_bloc.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<FirebaseAuth>(() => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.lazySingleton<GoogleSignIn>(() => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<IAuthFacade>(
      () => FirebaseAuthFacade(get<FirebaseAuth>(), get<GoogleSignIn>()));
  gh.lazySingleton<ICommentFacade>(
      () => FirebaseCommentFacade(get<FirebaseFirestore>()));
  gh.factory<SignInFormBloc>(() => SignInFormBloc(get<IAuthFacade>()));
  gh.lazySingleton<UploadFileManager>(
      () => FirestoreUploadFileManager(get<FirebaseStorage>()));
  gh.factory<CommentsBloc>(() => CommentsBloc(get<ICommentFacade>()));
  gh.lazySingleton<IPostFacade>(() => PostFacadeDefaultImpl(
      get<FirebaseFirestore>(), get<UploadFileManager>()));
  gh.factory<UserPostsBloc>(() => UserPostsBloc(get<IPostFacade>()));

  // Eager singletons must be registered in the right order
  gh.singleton<AuthBloc>(AuthBloc(get<IAuthFacade>()));
  gh.singleton<PostsBloc>(PostsBloc(get<IPostFacade>()));
  gh.singleton<ArActionsBloc>(ArActionsBloc(get<IPostFacade>()));
  return get;
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
