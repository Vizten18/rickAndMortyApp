// ignore_for_file: one_member_abstracts

abstract class UseCaseWithParams<Type, Params> {
  Future<Type> execute(Params parameters);
}

abstract class UseCaseWithoutParams<Type> {
  Future<Type> execute();
}
