enum Role { buyer, seller, undefine }

enum AuthType { login, signin }

class AuthAgrument {
  Role role;
  AuthType authType;

  AuthAgrument(this.role, this.authType);
}

class AuthTypeAgrument {
  AuthType authType;

  AuthTypeAgrument(this.authType);
}

Role stringToRoleEnum(String role) {
  switch (role) {
    case 'buyer':
      return Role.buyer;
    case 'seller':
      return Role.seller;
    default:
      return Role.undefine;
  }
}
