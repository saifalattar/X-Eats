abstract class AuthStates {}

class AuthInitState extends AuthStates {}

class ShowPassState extends AuthStates {}

class ChangeGenderState extends AuthStates {}

class FailgetInformation extends AuthStates {}

class SuccessGetInformation extends AuthStates {}

class SuccessEmailProfile extends AuthStates {}
