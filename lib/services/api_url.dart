class ProductsUrl{
  static const String _baseUrl = 'https://fakestoreapi.com';

  static String allProductsUrl = '$_baseUrl/products';
  static String specificProductsUrl = '$_baseUrl/products/';

  static String allCateogriesUrl = '$_baseUrl/products/categories';

  static String productSpecificCategoryUrl = '$_baseUrl/products/category/';

  static String sortDescProductUrl = '$_baseUrl/products?sort=desc';
  static String sortAscProductUrl = '$_baseUrl/products?sort=asc';

  static String cartItemsUrl = '$_baseUrl/carts/user/2';

  static String deleteCartItem = '$_baseUrl/carts/';
}

class AuthUrl{
  static String loginUrl = '${ProductsUrl._baseUrl}/auth/login';
}