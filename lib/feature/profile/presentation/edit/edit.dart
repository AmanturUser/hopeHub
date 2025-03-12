import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hope_hub/core/const/helper.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:hope_hub/feature/profile/domain/profile_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/const/const.dart';
import '../../../../core/const/form_status.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../bloc/profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.profile});

  final ProfileModel profile;

  @override
  State<EditProfileScreen> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late ProfileBloc _profileBloc;

  final ImagePicker _picker = ImagePicker();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  ClassUser? selectedClass;

  @override
  void initState() {
    name.text = widget.profile.name!;
    surname.text = widget.profile.surname!;
    _profileBloc = context.read<ProfileBloc>();
    selectedClass = widget.profile.classUser;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Редактировать профиль',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Аватар с кнопкой изменения
                Center(
                  child: Stack(
                    children: [
                      BlocConsumer<ProfileBloc, ProfileState>(
                        listenWhen: (previous, current) =>
                        previous.statusEdit != current.statusEdit,
                        listener: (context, state) async{
                          if (state.statusEdit ==
                              FormStatus.submissionSuccess) {
                            _profileBloc.add(const GetProfileEvent());
                          }
                          if (state.statusEdit ==
                              FormStatus.submissionFailure) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                  content: Text('Вышла ошибка',
                                      style: AppTextStyles.error)));
                          }
                        },
                        buildWhen: (previous, current) =>
                        previous.statusEdit != current.statusEdit || previous.status != current.status,
                        builder: (context, state) {
                          if (state.statusEdit ==
                              FormStatus.submissionInProgress || state.status ==
                              FormStatus.submissionInProgress) {
                            return const SizedBox(width: 100,height: 100,child: Center(child: CircularProgressIndicator()));
                          }
                          return Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xFFE8B172),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    scale: 4,
                                    image: state.profiles.first.photo != null
                                        ? NetworkImage(
                                        '${ApiUrl.baseUrl}/${state.profiles.first.photo}')
                                        : const AssetImage('assets/icons/avatar.png'),
                                    fit: state.profiles.first.photo != null
                                        ? BoxFit.cover
                                        : BoxFit.scaleDown)),
                          );
                        },
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
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
                              size: 24,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Поля формы
                _buildFormLabel('Имя'),
                _buildTextField(name),
                const SizedBox(height: 16),

                _buildFormLabel('Фамилия'),
                _buildTextField(surname),
                const SizedBox(height: 16),

                _buildFormLabel('Школа'),
                _buildDropdownSchoolField(widget.profile.school!),
                const SizedBox(height: 16),

                _buildFormLabel('Класс'),
                _buildDropdownField(
                    widget.profile.classUser!, widget.profile.classes!),
                const SizedBox(height: 32),

                // Кнопки действий
                BlocConsumer<ProfileBloc, ProfileState>(
                  listenWhen: (previous, current) =>
                  previous.statusEditInfo != current.statusEditInfo,
                  listener: (context, state) async {
                    if (state.statusEditInfo ==
                        FormStatus.submissionSuccess) {
                      context.read<DashboardBloc>().add(
                          const GetDashboardEvent());
                      Navigator.pop(context);
                    }
                    if (state.statusEditInfo ==
                        FormStatus.submissionFailure) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text('Вышла ошибка',
                                style: AppTextStyles.error)));
                    }
                  },
                  buildWhen: (previous, current) =>
                  previous.statusEditInfo != current.statusEditInfo,
                  builder: (context, state) {
                    if (state.statusEditInfo ==
                        FormStatus.submissionInProgress) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side:
                              const BorderSide(color: AppColors.mainGreen),
                              shadowColor: const Color(0xFF324000),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Отменить',
                              style: TextStyle(color: AppColors.mainGreen),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _saveProfile,
                            child: const Text('Сохранить'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 16),

                // Дополнительные действия
                /*_buildActionButton(
                  Icons.logout,
                  'Выйти',
                  onTap: () {
                    // Обработка выхода
                  },
                ),*/
                /*const SizedBox(height: 16),
                _buildActionButton(
                  Icons.delete_outline,
                  'Удалить аккаунт',
                  color: Colors.red,
                  onTap: () {
                    // Обработка удаления аккаунта
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (value) => validateController(value),
    );
  }

  Widget _buildDropdownSchoolField(String value) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        items: [value].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          // Обработка изменения значения
        },
      ),
    );
  }

  Widget _buildDropdownField(ClassUser value, List<ClassUser> classes) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<ClassUser>(
        value: value,
        items: [value, ...classes].map((ClassUser valueSecond) {
          return DropdownMenuItem<ClassUser>(
            value: valueSecond,
            child: Text(valueSecond.name!),
          );
        }).toList(),
        onChanged: (ClassUser? newValue) {
          selectedClass = newValue;
          setState(() {});
          // Обработка изменения значения
        },
      ),
    );
  }

  Widget _buildActionButton(IconData icon,
      String label, {
        Color? color,
        required VoidCallback onTap,
      }) {
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

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      // Сохранение данных профиля
      _profileBloc.add(EditProfileEvent(
          name: name.text, surname: surname.text, classUser: selectedClass!));
    }
  }


  _selectImg(BuildContext context, ImageSource src) async {
    final Future<XFile?> imageFut = _picker.pickImage(
        source: src,
        maxWidth: 1000,
        maxHeight: 1000,
        requestFullMetadata: false);
    imageFut.then((image) async {
      await _profileBloc
        ..add(ProfileImageChanged(image!));
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
}
