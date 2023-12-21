abstract class ContactState {}
class InitialContactState extends ContactState{}
class InsertDataSuccessContactState extends ContactState{}
class InsertDataErrorContactState extends ContactState{}


class GetDataLoadingContactState extends ContactState{}
class GetDataSuccessContactState extends ContactState{}
class GetDataErrorContactState extends ContactState{}



class DeleteDataSuccessContactState extends ContactState{}
class DeleteDataErrorContactState extends ContactState{}

class UpdateFavoriteSuccessContactState extends ContactState{}
class UpdateFavoriteErrorContactState extends ContactState{}

class UpdateSuccessContactState extends ContactState{}
class UpdateErrorContactState extends ContactState{}

class ChangNavContactState extends ContactState{}