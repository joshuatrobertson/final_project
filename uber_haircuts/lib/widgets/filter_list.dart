import 'package:uber_haircuts/models/parent_barber.dart';

class FilterList {

  // Order by highest rated and return the top 5
  Future<List<ParentBarberModel>> getTopRatedParents(List<ParentBarberModel> parents) async {
      parents.sort((a, b) => b.rating.compareTo(a.rating));
    return parents.take(5).toList();
  }

  // Find the featured parents, although this should always only be 2, filter just in case
  Future<List<ParentBarberModel>> getFeaturedParents(List<ParentBarberModel> parents) async =>
    parents.where((element) => element.featured == true).take(2).toList();

}
