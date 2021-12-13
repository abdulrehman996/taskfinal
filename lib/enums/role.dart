enum Role {
  distributor('Distributor', 'distributor', 'assets/icons/distributor.png'),
  factory('Factory', 'factory', 'assets/icons/factory.png'),
  wholesaler('Wholesaler', 'wholesaler', 'assets/icons/wholesaler.png'),
  retailer('Retailer', 'retailer', 'assets/icons/retailer.png');

  const Role(this.title, this.json, this.iconPath);
  final String title;
  final String json;
  final String iconPath;
}

class RoleConvertor {
  Role toEnum(String role) {
    switch (role) {
      case 'distributor':
        return Role.distributor;
      case 'factory':
        return Role.factory;
      case 'wholesaler':
        return Role.wholesaler;
      case 'retailer':
        return Role.retailer;
      default:
        return Role.retailer;
    }
  }

  Role sellTo(Role value) {
    switch (value) {
      case Role.factory:
        return Role.distributor;
      case Role.distributor:
        return Role.wholesaler;
      case Role.wholesaler:
        return Role.retailer;
      case Role.retailer:
        return Role.retailer;
      default:
        return Role.retailer;
    }
  }

  Role buyFrom(Role value) {
    switch (value) {
      case Role.factory:
        return Role.factory;
      case Role.distributor:
        return Role.factory;
      case Role.wholesaler:
        return Role.distributor;
      case Role.retailer:
        return Role.wholesaler;
      default:
        return Role.factory;
    }
  }
}
