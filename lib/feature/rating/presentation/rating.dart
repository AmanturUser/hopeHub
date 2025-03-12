import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hope_hub/core/const/userData.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/feature/rating/domain/rating_schools_model.dart';

import '../../../core/const/const.dart';
import '../../../core/const/form_status.dart';
import '../../profile/presentation/bloc/profile_bloc.dart';
import '../domain/rating_model.dart';
import 'bloc/rating_bloc.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen>
    with TickerProviderStateMixin {
  late RatingBloc _ratingBloc;
  final _scrollController1 =
      ScrollController(); // Отдельный контроллер для первой вкладки
  final _scrollController2 = ScrollController();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _ratingBloc = context.read<RatingBloc>();
    _ratingBloc.add(const GetRatingEvent());
    _scrollController1.addListener(() => _onScrollFirst(_scrollController1));
    _scrollController2.addListener(() => _onScrollSecond(_scrollController2));
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        context
            .read<RatingBloc>()
            .add(const ChangeRatingEvent(userOrSchool: true));
      } else {
        context
            .read<RatingBloc>()
            .add(const ChangeRatingEvent(userOrSchool: false));
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onScrollFirst(ScrollController controller) {
    if (_isBottom(controller)) {
      _ratingBloc.add(const LoadMoreEvent(true));
    }
  }

  void _onScrollSecond(ScrollController controller) {
    if (_isBottom(controller)) {
      _ratingBloc.add(const LoadMoreEvent(false));
    }
  }

  bool _isBottom(ScrollController controller) {
    if (!controller.hasClients) return false;
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    return currentScroll >=
        maxScroll; // Загружаем новые данные когда долистали до 90%
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<RatingBloc, RatingState>(
            buildWhen: (previous, current) =>
                previous.status != current.status ||
                previous.statusLoadMore != current.statusLoadMore ||
                previous.userOrSchool != current.userOrSchool ||
                previous.rating != current.rating,
            bloc: _ratingBloc..add(const GetRatingEvent()),
            builder: (context, state) {
              if (state.status == FormStatus.submissionFailure) {
                return RefreshIndicator(
                  onRefresh: () async {
                    _ratingBloc.add(const GetRatingEvent());
                  },
                  child: ListView(
                    children: [
                      Center(
                          child: Text(
                        'Вышла ошибка',
                        style: AppTextStyles.error,
                      )),
                    ],
                  ),
                );
              }
              if (state.status == FormStatus.submissionSuccess) {
                print('schoolId ${state.sId}');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Рейтинг социальной активности',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Профиль пользователя
                        if (state.userOrSchool)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: ClipRect(
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFE8B172),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            scale: 4,
                                            image: state.photo != ''
                                                ? NetworkImage(
                                                    '${ApiUrl.baseUrl}/${state.photo}')
                                                : const AssetImage(
                                                    'assets/icons/avatar.png'),
                                            fit: state.photo != ''
                                                ? BoxFit.cover
                                                : BoxFit.scaleDown)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${state.name} ${state.surname}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/icons/coin.png',
                                          width: 25,
                                          height: 25,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${state.rating} баллов',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        if (!state.userOrSchool)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/icons/education.png'),
                                          fit: BoxFit.scaleDown)),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.schoolName,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/icons/coin.png',
                                          width: 25,
                                          height: 25,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${state.schoolRating} баллов',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 32),
                      ],
                    ),

                    // Табы рейтинга
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              _ratingBloc.add(const ChangeRatingEvent(userOrSchool: true));
                            },
                            child: _buildRatingTab(
                              'Школьный рейтинг',
                              state.userOrSchool,
                            )),
                        InkWell(
                            onTap: () {
                              _ratingBloc.add(const ChangeRatingEvent(userOrSchool: false));
                            },
                            child: _buildRatingTab(
                              'Общий рейтинг',
                              !state.userOrSchool,
                            )),
                      ],
                    ),*/

                    TabBar(
                      labelColor: AppColors.mainGreen,
                      indicatorColor: AppColors.mainGreen,
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Школьный рейтинг'),
                        Tab(text: 'Общий рейтинг'),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Список рейтинга
                    /*if(state.userOrSchool)
                    _buildRatingList(state.users),

                    if(!state.userOrSchool)
                      ..._buildRatingSchoolList(state.schools),

                    if (state.statusLoadMore ==
                        FormStatus.submissionInProgress || state.statusLoadMoreSchool ==
                        FormStatus.submissionInProgress)
                      const Center(child: CircularProgressIndicator()),*/

                    Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        RefreshIndicator(
                          onRefresh: () async {
                            _ratingBloc.add(const GetRatingEvent());
                          },
                          child: ListView(
                              controller: _scrollController1,
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              children: state.users
                                  .map((item) => Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 8),
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: item.sId==UserData.userId ? AppColors.mainGreen : Color(0xFFEEEBCE),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${item.name!}, ${item.className!.replaceAll('асс', '').toLowerCase()}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: item.sId==UserData.userId ? Colors.white : Colors.black
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/coin.png',
                                                  width: 25,
                                                  height: 25,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  item.rating.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList()),
                        ),
                        RefreshIndicator(
                          onRefresh: () async {
                            _ratingBloc.add(const GetRatingEvent());
                          },
                          child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _scrollController2,
                              padding: const EdgeInsets.all(16),
                              children: state.schools
                                  .map((item) => Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 8),
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color:  item.sId==state.sId ? AppColors.mainGreen : Color(0xFFEEEBCE),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item.schoolName!,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                    color: item.sId==state.sId ? Colors.white : Colors.black
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/coin.png',
                                                  width: 25,
                                                  height: 25,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  item.rating.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList()),
                        ),
                      ]),
                    )
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRatingTab(String text, bool isSelected) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? Colors.black87 : Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        if (isSelected)
          Container(
            height: 2,
            width: 140,
            color: const Color(0xFF8B9B6B),
          ),
      ],
    );
  }

  /*Widget _buildRatingList(List<Users> users) {
    return Expanded(
      child: TabBarView(
          controller: _tabController,
          children:
          [
            RefreshIndicator(
              onRefresh: () async {
                _ratingBloc.add(const GetRatingEvent());
              },
              child: ListView(
                  controller: _scrollController,
                  padding:  const EdgeInsets.all(16),
                  children :
                  users
                      .map((item) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEBCE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${item.name!}, ${item.className!.replaceAll('асс', '').toLowerCase()}, ${item.schoolName!.replaceAll('ола', '').replaceAll('Ш', 'ш')}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/coin.png',
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item.rating.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
                      .toList()
              ),
            ),]
      ),
    );

  }*/

  List<Widget> _buildRatingSchoolList(List<Schools> schools) {
    return schools
        .map((item) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEEEBCE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.schoolName!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/coin.png',
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.rating.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))
        .toList();
  }
}
