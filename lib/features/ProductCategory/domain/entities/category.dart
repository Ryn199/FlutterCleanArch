import 'package:equatable/equatable.dart';

class Category extends Equatable{

  final String id;
  final String categoryName;
  final String desc;

  const Category(
    {
      required this.id,
      required this.categoryName,
      required this.desc,
    }
  );

  @override
  List<Object?> get props => [id, categoryName, desc];
  
}