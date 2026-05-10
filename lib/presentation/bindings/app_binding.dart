import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/data/datasources/auth_remote_data_source.dart';
import 'package:profhunterapp/data/datasources/chat_remote_data_source.dart';
import 'package:profhunterapp/data/datasources/message_remote_data_source.dart';
import 'package:profhunterapp/data/datasources/response_remote_data_source.dart';
import 'package:profhunterapp/data/datasources/vacancy_remote_data_source.dart';
import 'package:profhunterapp/data/repositories/auth_repository_impl.dart';
import 'package:profhunterapp/data/repositories/chat_repository_impl.dart';
import 'package:profhunterapp/data/repositories/message_repository_impl.dart';
import 'package:profhunterapp/data/repositories/response_repository_impl.dart';
import 'package:profhunterapp/data/repositories/vacancy_repository_impl.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';
import 'package:profhunterapp/domain/repositories/chat_repository.dart';
import 'package:profhunterapp/domain/repositories/message_repository.dart';
import 'package:profhunterapp/domain/repositories/response_repository.dart';
import 'package:profhunterapp/domain/repositories/vacancy_repository.dart';
import 'package:profhunterapp/domain/usecases/get_chat.dart';
import 'package:profhunterapp/domain/usecases/create_vacancy.dart';
import 'package:profhunterapp/domain/usecases/create_vacancy_response.dart';
import 'package:profhunterapp/domain/usecases/get_message_from_chat.dart';
import 'package:profhunterapp/domain/usecases/get_user_by_id.dart';
import 'package:profhunterapp/domain/usecases/get_user_responses.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies_company.dart';
import 'package:profhunterapp/domain/usecases/get_vacancy_by_id.dart';
import 'package:profhunterapp/domain/usecases/insubscribe_message.dart';
import 'package:profhunterapp/domain/usecases/restore_current_user.dart';
import 'package:profhunterapp/domain/usecases/send_message.dart';
import 'package:profhunterapp/domain/usecases/sign_in.dart';
import 'package:profhunterapp/domain/usecases/sign_out.dart';
import 'package:profhunterapp/domain/usecases/sign_up.dart';
import 'package:profhunterapp/domain/usecases/subscribe_message.dart';
import 'package:profhunterapp/domain/usecases/update_user.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/controllers/chat_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBinding extends Bindings {
  final SharedPreferences prefs;

  AppBinding(this.prefs);

  @override
  void dependencies() {
    final pb = PocketBase(
      'https://pocketbase-latest-9x81.onrender.com/',
      authStore: AsyncAuthStore(
        initial: prefs.getString('pb_auth'),
        save: (data) async => prefs.setString('pb_auth', data),
        clear: () async => prefs.remove('pb_auth'),
      ),
    );

    Get.put<PocketBase>(pb, permanent: true);

    // Auth
    Get.put<AuthRemoteDataSource>(AuthRemoteDataSource(pb), permanent: true);

    Get.put<AuthRepository>(
      AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()),
      permanent: true,
    );

    Get.lazyPut<SignIn>(() => SignIn(Get.find<AuthRepository>()), fenix: true);

    Get.lazyPut<SignUp>(() => SignUp(Get.find<AuthRepository>()), fenix: true);

    Get.lazyPut<SignOut>(
      () => SignOut(Get.find<AuthRepository>()),
      fenix: true,
    );

    Get.lazyPut<UpdateUser>(
      () => UpdateUser(Get.find<AuthRepository>()),
      fenix: true,
    );

    Get.put<RestoreCurrentUser>(
      RestoreCurrentUser(Get.find<AuthRepository>()),
      permanent: true,
    );

    Get.lazyPut<GetUserById>(
      () => GetUserById(Get.find<AuthRepository>()),
      fenix: true,
    );

    Get.put<AuthController>(
      AuthController(
        signInUseCase: Get.find<SignIn>(),
        signUpUseCase: Get.find<SignUp>(),
        signOutUseCase: Get.find<SignOut>(),
        updateUserUseCase: Get.find<UpdateUser>(),
        restoreCurrentUserUseCase: Get.find<RestoreCurrentUser>(),
        getUserByIdUseCase: Get.find<GetUserById>(),
      ),
      permanent: true,
    );

    // Vacancies dependencies
    Get.put<VacancyRemoteDataSource>(
      VacancyRemoteDataSource(pb: Get.find<PocketBase>()),
      permanent: true,
    );

    Get.put<VacancyRepository>(
      VacancyRepositoryImpl(
        remoteDataSource: Get.find<VacancyRemoteDataSource>(),
      ),
      permanent: true,
    );

    Get.lazyPut<GetVacancies>(
      () => GetVacancies(repository: Get.find<VacancyRepository>()),
      fenix: true,
    );

    Get.lazyPut<GetVacanciesCompany>(
      () => GetVacanciesCompany(repository: Get.find<VacancyRepository>()),
      fenix: true,
    );

    Get.lazyPut<GetVacancyById>(
      () => GetVacancyById(repository: Get.find<VacancyRepository>()),
      fenix: true,
    );

    Get.lazyPut<CreateVacancy>(
      () => CreateVacancy(repository: Get.find<VacancyRepository>()),
      fenix: true,
    );

    // Response dependencies
    Get.put<ResponseRemoteDataSource>(
      ResponseRemoteDataSource(Get.find<PocketBase>()),
      permanent: true,
    );

    Get.put<ResponseRepository>(
      ResponseRepositoryImpl(Get.find<ResponseRemoteDataSource>()),
      permanent: true,
    );

    Get.lazyPut<CreateVacancyResponse>(
      () => CreateVacancyResponse(Get.find<ResponseRepository>()),
      fenix: true,
    );

    Get.lazyPut<GetUserResponses>(
      () => GetUserResponses(Get.find<ResponseRepository>()),
      fenix: true,
    );

    // Chat and message dependencies
    Get.put<ChatRemoteDataSource>(
      ChatRemoteDataSource(Get.find<PocketBase>()),
      permanent: true,
    );

    Get.put<MessageRemoteDataSource>(
      MessageRemoteDataSource(Get.find<PocketBase>()),
      permanent: true,
    );

    Get.put<ChatRepository>(
      ChatRepositoryImpl(Get.find<ChatRemoteDataSource>()),
      permanent: true,
    );

    Get.put<MessageRepository>(
      MessageRepositoryImpl(Get.find<MessageRemoteDataSource>()),
      permanent: true,
    );

    Get.lazyPut<GetChat>(
      () => GetChat(Get.find<ChatRepository>()),
      fenix: true,
    );

    Get.lazyPut<SendMessage>(
      () => SendMessage(Get.find<MessageRepository>()),
      fenix: true,
    );

    Get.lazyPut<GetMessageFromChat>(
      () => GetMessageFromChat(Get.find<MessageRepository>()),
      fenix: true,
    );

    Get.lazyPut<SubscribeMessages>(
      () => SubscribeMessages(Get.find<ChatRepository>()),
      fenix: true,
    );

    Get.lazyPut<UnsubscribeMessages>(
      () => UnsubscribeMessages(Get.find<ChatRepository>()),
      fenix: true,
    );

    Get.lazyPut<ChatController>(
      () => ChatController(
        getChatUseCase: Get.find<GetChat>(),
        sendMessageUseCase: Get.find<SendMessage>(),
        getMessageFromChatUseCase: Get.find<GetMessageFromChat>(),
        subscribeMessagesUseCase: Get.find<SubscribeMessages>(),
        unsubscribeMessagesUseCase: Get.find<UnsubscribeMessages>(),
      ),
      fenix: true,
    );
  }
}
