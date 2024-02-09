// ignore_for_file: file_names

class Profile {
  final int id;
  final String name;
  final String email;
  final DateTime? emailVerifiedAt;
  final String password;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProfileDetails profileDetails;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.profileDetails,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      password: json['password'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      profileDetails: ProfileDetails.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'password': password,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'profile': profileDetails.toJson(),
    };
  }
}

class ProfileDetails {
  final int id;
  final int usersId;
  final String nikProfile;
  final String namaProfile;
  final String emailProfile;
  final String alamatProfile;
  final String nohpProfile;
  final String jeniskelaminProfile;
  final String gambarProfile;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String codeProfile;
  final int jabatanId;
  final int unitId;
  final int categoryOfficeId;
  final int usersidAtasan;
  final Jabatan jabatan;
  final Unit unit;
  final CategoryOffice categoryOffice;

  ProfileDetails({
    required this.id,
    required this.usersId,
    required this.nikProfile,
    required this.namaProfile,
    required this.emailProfile,
    required this.alamatProfile,
    required this.nohpProfile,
    required this.jeniskelaminProfile,
    required this.gambarProfile,
    required this.createdAt,
    required this.updatedAt,
    required this.codeProfile,
    required this.jabatanId,
    required this.unitId,
    required this.categoryOfficeId,
    required this.usersidAtasan,
    required this.jabatan,
    required this.unit,
    required this.categoryOffice,
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return ProfileDetails(
      id: json['id'],
      usersId: json['users_id'],
      nikProfile: json['nik_profile'],
      namaProfile: json['nama_profile'],
      emailProfile: json['email_profile'],
      alamatProfile: json['alamat_profile'],
      nohpProfile: json['nohp_profile'],
      jeniskelaminProfile: json['jeniskelamin_profile'],
      gambarProfile: json['gambar_profile'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      codeProfile: json['code_profile'],
      jabatanId: json['jabatan_id'],
      unitId: json['unit_id'],
      categoryOfficeId: json['category_office_id'],
      usersidAtasan: json['usersid_atasan'],
      jabatan: Jabatan.fromJson(json['jabatan']),
      unit: Unit.fromJson(json['unit']),
      categoryOffice: CategoryOffice.fromJson(json['category_office']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users_id': usersId,
      'nik_profile': nikProfile,
      'nama_profile': namaProfile,
      'email_profile': emailProfile,
      'alamat_profile': alamatProfile,
      'nohp_profile': nohpProfile,
      'jeniskelamin_profile': jeniskelaminProfile,
      'gambar_profile': gambarProfile,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'code_profile': codeProfile,
      'jabatan_id': jabatanId,
      'unit_id': unitId,
      'category_office_id': categoryOfficeId,
      'usersid_atasan': usersidAtasan,
      'jabatan': jabatan.toJson(),
      'unit': unit.toJson(),
      'category_office': categoryOffice.toJson(),
    };
  }
}

class Jabatan {
  final int id;
  final String namaJabatan;
  final String? isNode;
  final String? isChildren;
  final DateTime createdAt;
  final DateTime updatedAt;

  Jabatan({
    required this.id,
    required this.namaJabatan,
    required this.isNode,
    required this.isChildren,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Jabatan.fromJson(Map<String, dynamic> json) {
    return Jabatan(
      id: json['id'],
      namaJabatan: json['nama_jabatan'],
      isNode: json['is_node'],
      isChildren: json['is_children'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_jabatan': namaJabatan,
      'is_node': isNode,
      'is_children': isChildren,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Unit {
  final int id;
  final String namaUnit;
  final String? isNode;
  final String? isChildren;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Unit({
    required this.id,
    required this.namaUnit,
    required this.isNode,
    required this.isChildren,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      namaUnit: json['nama_unit'],
      isNode: json['is_node'],
      isChildren: json['is_children'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_unit': namaUnit,
      'is_node': isNode,
      'is_children': isChildren,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class CategoryOffice {
  final int id;
  final String namaCategoryOffice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategoryOffice({
    required this.id,
    required this.namaCategoryOffice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryOffice.fromJson(Map<String, dynamic> json) {
    return CategoryOffice(
      id: json['id'],
      namaCategoryOffice: json['nama_category_office'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_category_office': namaCategoryOffice,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class ResponseProfile {
  Profile profile;
  Profile atasan;

  ResponseProfile({
    required this.profile,
    required this.atasan,
  });

  factory ResponseProfile.fromJson(Map<String, dynamic> json) {
    return ResponseProfile(
      profile: Profile.fromJson(json['profile']),
      atasan: Profile.fromJson(json['atasan']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': profile.toJson(),
      'atasan': atasan.toJson(),
    };
  }
}
