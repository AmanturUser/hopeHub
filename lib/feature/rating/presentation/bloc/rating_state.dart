part of 'rating_bloc.dart';

class RatingState extends Equatable {
  const RatingState(
      {this.status = FormStatus.pure,
      this.statusLoadMore = FormStatus.pure,
      this.statusLoadMoreSchool = FormStatus.pure,
      this.userOrSchool = true,
      this.name = '',
      this.sId = '',
      this.surname = '',
      this.rating = 0,
      this.page = 0,
      this.totalPage = 0,
      this.schoolName = '',
      this.schoolRating = 0,
      this.schoolPage = 0,
      this.totalSchoolPage = 0,
      this.photo = '',
      this.users = const [],
      this.schools = const [],
      });

  final FormStatus status;
  final FormStatus statusLoadMore;
  final FormStatus statusLoadMoreSchool;
  final bool userOrSchool;
  final String sId;
  final String name;
  final String surname;
  final int rating;
  final int page;
  final int totalPage;
  final String schoolName;
  final int schoolRating;
  final int schoolPage;
  final int totalSchoolPage;
  final String photo;
  final List<Users> users;
  final List<Schools> schools;

  RatingState copyWith(
      {
      FormStatus? status,
      FormStatus? statusLoadMore,
      FormStatus? statusLoadMoreSchool,
      bool? userOrSchool,
      String? sId,
      String? name,
      String? surname,
      int? rating,
      int? page,
      int? totalPage,
      String? schoolName,
      int? schoolRating,
      int? schoolPage,
      int? totalSchoolPage,
      String? photo,
      List<Users>? users,
      List<Schools>? schools
      }) {
    return RatingState(
      status: status ?? this.status,
      statusLoadMore: statusLoadMore ?? this.statusLoadMore,
      statusLoadMoreSchool: statusLoadMoreSchool ?? this.statusLoadMoreSchool,
      userOrSchool: userOrSchool ?? this.userOrSchool,
      sId: sId ?? this.sId,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      rating: rating ?? this.rating,
      page: page ?? this.page,
      totalPage: totalPage ?? this.totalPage,
      schoolName: schoolName ?? this.schoolName,
      schoolRating: schoolRating ?? this.schoolRating,
      schoolPage: schoolPage ?? this.schoolPage,
      totalSchoolPage: totalSchoolPage ?? this.totalSchoolPage,
      photo: photo ?? this.photo,
      users: users ?? this.users,
      schools: schools ?? this.schools,
    );
  }

  @override
  List<Object> get props => [
        status,
        statusLoadMore,
        userOrSchool,
        sId,
        name,
        surname,
        rating,
        page,
        totalPage,
        schoolName,
        schoolRating,
        schoolPage,
        totalSchoolPage,
        photo,
        users,
        schools,
      ];
}
