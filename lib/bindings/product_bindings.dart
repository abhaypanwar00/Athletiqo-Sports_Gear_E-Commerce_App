// import 'package:athletiqo/data/repository/product/add_product_repository.dart';
// import 'package:athletiqo/data/repository/product/brand_category_repository.dart';
// import 'package:athletiqo/data/repository/product/brand_repository.dart';
// import 'package:athletiqo/data/repository/product/category_repository.dart';
// import 'package:get/get.dart';

// class ProductBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<BrandRepository>(() => BrandRepository());
//     Get.lazyPut<CategoryRepository>(() => CategoryRepository());
//     Get.lazyPut<BrandCategoryRepository>(() => BrandCategoryRepository());
//     Get.lazyPut<ProductRepository>(() => ProductRepository(
//       brandRepo: Get.find(),
//       categoryRepo: Get.find(),
//       brandCategoryRepo: Get.find(),
//     ));
//   }
// }