class Filter {

  bool asc;
  String term;
  Function apply;

  Filter({this.term, this.apply, this.asc = true});

}
