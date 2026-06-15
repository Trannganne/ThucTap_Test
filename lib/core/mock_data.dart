class MockUser {
  final String username;
  final String password;
  final String fullName;
  final String email;
  final List<String> roles;

  const MockUser({
    required this.username,
    required this.password,
    required this.fullName,
    required this.email,
    required this.roles,
  });
}

class MockCompany {
  final String code;
  final String name;

  const MockCompany({required this.code, required this.name});
}

class MockData {
  static const List<MockCompany> companies = [
    MockCompany(code: 'VTT001', name: 'Viettel Telecom'),
    MockCompany(code: 'VTT002', name: 'Viettel Solutions'),
    MockCompany(code: 'VTT003', name: 'Viettel Post'),
  ];

  static const List<MockUser> users = [
    MockUser(
      username: 'vananh',
      password: '123456',
      fullName: 'Nguyễn Văn Anh',
      email: 'nguyen.van.anh@viettel.com.vn',
      roles: ['Giám sát', 'Nhân viên kinh doanh'],
    ),
    MockUser(
      username: 'admin',
      password: 'admin',
      fullName: 'Admin User',
      email: 'admin@viettel.com.vn',
      roles: ['Quản lý', 'Giám sát', 'Nhân viên kinh doanh'],
    ),
  ];

  static MockUser? authenticate(String username, String password) {
    try {
      return users.firstWhere(
        (u) => u.username == username && u.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  static bool isValidCompanyCode(String code) {
    return companies.any((c) => c.code == code);
  }

  static String? getCompanyName(String code) {
    try {
      return companies.firstWhere((c) => c.code == code).name;
    } catch (_) {
      return null;
    }
  }
}
