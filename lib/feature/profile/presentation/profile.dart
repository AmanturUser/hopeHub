import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hope_hub/core/auto_route/auto_route.dart';
import 'package:hope_hub/core/const/form_status.dart';
import 'package:hope_hub/feature/profile/presentation/edit/edit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/const/alertDialog.dart';
import '../../../core/const/const.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_text_styles.dart';
import 'bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc _profileBloc;
  @override
  void initState() {
    _profileBloc = context.read<ProfileBloc>();
    _profileBloc.add(const GetProfileEvent());
    // TODO: implement initState
    super.initState();
  }
  final ImagePicker _picker = ImagePicker();

  _selectImg(BuildContext context, ImageSource src) async {
    final Future<XFile?> imageFut = _picker.pickImage(
        source: src,
        maxWidth: 1000,
        maxHeight: 1000,
        requestFullMetadata: false);
    imageFut.then((image) async{
      await _profileBloc..add(ProfileImageChanged(image!));
    });
  }
  _openModal() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        builder: (context) =>
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Выбрать из галереи'),
                  onTap: () {
                    _selectImg(context, ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: const Text('Сделать фото'),
                  onTap: () {
                    _selectImg(context, ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(90),
                  topRight: Radius.circular(90),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x171D011A).withOpacity(0.1),
                    blurRadius: 25,
                  )
                ],
                color: AppColors.authContainerBackground,
              ),
              child: BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if(state.statusEdit == FormStatus.submissionSuccess){
                    _profileBloc.add(const GetProfileEvent());
                  }
                  if(state.statusDelete == FormStatus.submissionSuccess){
                    AutoRouter.of(context)
                        .replaceAll([const SignInRoute()]);
                  }
                  if(state.statusDelete == FormStatus.submissionFailure){
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Text('Вышла ошибка',
                              style:
                              AppTextStyles.error)));
                  }
                },
                listenWhen: (previous, current) => previous.statusEdit != current.statusEdit || previous.statusDelete != current.statusDelete || previous.statusEditInfo != current.statusEditInfo,
                buildWhen: (previous, current) =>
                previous.status != current.status || previous.statusEditInfo != current.statusEditInfo,
                builder: (context, state) {
                  if(state.status == FormStatus.submissionInProgress){
                    return SizedBox(
                      height: MediaQuery.of(context).size.height-(MediaQuery.of(context).size.height * 0.3),
                        child: const Center(child: CircularProgressIndicator()));
                  }
                  if(state.status == FormStatus.submissionFailure){
                    return RefreshIndicator(
                      onRefresh: ()async{
                        _profileBloc.add(const GetProfileEvent());
                      },
                      child: ListView(
                        children: [
                          const Center(child: Text('Вышла ошибка')),
                          _ActionButton(
                            icon: Icons.logout,
                            label: 'Выйти',
                            onTap: () {
                              var dialog = CustomAlertDialog(
                                  title: "Выход",
                                  message: "Вы хотите выйти?",
                                  onPostivePressed: () async {
                                    await const FlutterSecureStorage().delete(key: 'token');
                                    await const FlutterSecureStorage().delete(key: 'userId');
                                    AutoRouter.of(context)
                                        .replaceAll([const SignInRoute()]);
                                  },
                                  positiveBtnText: "Да",
                                  negativeBtnText: "Нет",
                                  onNegativePressed: () async {});
                              showDialog(
                                  context: context, builder: (BuildContext context) => dialog);
                              // Обработка выхода
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  if(state.status == FormStatus.submissionSuccess || state.statusEditInfo == FormStatus.submissionSuccess){
                    return RefreshIndicator(
                      onRefresh: ()async{
                        _profileBloc.add(const GetProfileEvent());
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            // Профиль с аватаром и рейтингом
                            _buildProfileHeader(state),
                            const SizedBox(height: 24),


                            // Статистика
                            _buildStatistics(state),
                            const SizedBox(height: 32),

                            // Информация о пользователе
                            _buildUserInfo(state),
                            const SizedBox(height: 32),
                            const Divider(),
                            // Кнопки действий
                            _buildActionButtons(context,state),
                          ],
                        ),
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: ()async{
                      _profileBloc.add(const GetProfileEvent());
                    },
                    child: ListView(
                      children: [
                        const SizedBox(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ProfileState state) {
    print('${ApiUrl.baseUrl}/${state.profiles.first.photo}');
    return Column(
      children: [
        Stack(
          children: [
            ClipRect(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8B172),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    scale: 4,
                    image: state.profiles.first.photo!=null ? NetworkImage('${ApiUrl.baseUrl}/${state.profiles.first.photo}') : const AssetImage('assets/icons/avatar.png'),
                    fit: state.profiles.first.photo!=null ? BoxFit.cover : BoxFit.scaleDown
                  )
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: InkWell(
                onTap: (){
                  _openModal();
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icons/coin.png', width: 40, height: 40),
            const SizedBox(width: 8),
            Text(
              state.profiles.first.rating.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Рейтинг социальной активности',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildStatistics(ProfileState state) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F1D4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(number: state.profiles.first.ideas.toString(), label: 'Инициатив'),
          const _VerticalDivider(),
          _StatItem(number: state.profiles.first.surveys.toString(), label: 'Голосований'),
          const _VerticalDivider(),
          _StatItem(number: state.profiles.first.projects.toString(), label: 'Проекта'),
        ],
      ),
    );
  }

  Widget _buildUserInfo(ProfileState state) {
    return Column(
      children: [
        _InfoItem(
          icon: Icons.person_outline,
          text: '${state.profiles.first.name!} ${state.profiles.first.surname!}',
        ),
        const SizedBox(height: 16),
        _InfoItem(
          icon: Icons.school_outlined,
          text: state.profiles.first.school!,
        ),
        const SizedBox(height: 16),
        _InfoItem(
          icon: Icons.class_outlined,
          text: state.profiles.first.classUser!.name!,
        ),

      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, ProfileState state) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfileScreen(profile: state.profiles.first)),
                  );
                  // Обработка редактирования профиля
                },
                child: const Text('Редактировать профиль'),
              ),
            ),
          ],
        ),
        _ActionButton(
          icon: Icons.logout,
          label: 'Выйти',
          onTap: () {
            var dialog = CustomAlertDialog(
                title: "Выход",
                message: "Вы хотите выйти?",
                onPostivePressed: () async {
                  await const FlutterSecureStorage().delete(key: 'token');
                  await const FlutterSecureStorage().delete(key: 'userId');
                  AutoRouter.of(context)
                      .replaceAll([const SignInRoute()]);
                },
                positiveBtnText: "Да",
                negativeBtnText: "Нет",
                onNegativePressed: () async {});
            showDialog(
                context: context, builder: (BuildContext context) => dialog);
            // Обработка выхода
          },
        ),
        const SizedBox(height: 8),
        if(state.statusDelete==FormStatus.submissionInProgress)
          const Center(child: CircularProgressIndicator()),
        if(state.statusDelete!=FormStatus.submissionInProgress)
        _ActionButton(
          icon: Icons.delete_outline,
          label: 'Удалить аккаунт',
          color: Colors.red,
          onTap: () {
            var dialog = CustomAlertDialog(
                title: "Удалить аккаунт",
                message: "Вы хотите удалить аккаунт?",
                onPostivePressed: () async {
                  AutoRouter.of(context)
                      .replaceAll([const SignInRoute()]);
                  _profileBloc.add(const DeleteAccountEvent());
                },
                positiveBtnText: "Да",
                negativeBtnText: "Нет",
                onNegativePressed: () async {});
            showDialog(
                context: context, builder: (BuildContext context) => dialog);

            // Обработка удаления аккаунта
          },
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;

  const _StatItem({
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 2,
      color: const Color(0xFFADB29B),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54, size: 24),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? Colors.black87,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: color ?? Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );


  }
}