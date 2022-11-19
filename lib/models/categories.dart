enum ProductType {
  undefine,
  fish,
  meat,
  spice,
  fruit,
  vegetable,
  seafood,
}

String categories(ProductType type) {
  switch (type) {
    case ProductType.fish:
      return 'fish';
    case ProductType.meat:
      return 'meat';
    case ProductType.spice:
      return 'spice';
    case ProductType.fruit:
      return 'fruit';
    case ProductType.vegetable:
      return 'vegetable';
    case ProductType.seafood:
      return 'seafood';
    default:
      return 'undefine';
  }
}

String categoriName(ProductType type) {
  switch (type) {
    case ProductType.fish:
      return 'Cá';
    case ProductType.meat:
      return 'Thịt';
    case ProductType.spice:
      return 'Gia Vị';
    case ProductType.fruit:
      return 'Trái cây';
    case ProductType.vegetable:
      return 'Rau';
    case ProductType.seafood:
      return 'Hải sản';
    default:
      return 'Khác';
  }
}

ProductType toProductType(String type){
switch (type) {
    case 'fish':
      return ProductType.fish;
    case 'meat':
      return ProductType.meat;
    case 'spice':
      return ProductType.spice;
    case 'shrimp':
      return ProductType.fruit;
    case 'crab':
      return ProductType.vegetable;
    case 'seafood':
      return ProductType.seafood;
    default:
      return ProductType.undefine;
  }
}