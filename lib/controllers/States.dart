abstract class XeatsStates {}

class SuperXeats extends XeatsStates {}

class SuperXeatsOff extends SuperXeats {
  final bool isPassword;

  SuperXeatsOff(this.isPassword);
}

class ChangeSuccefully extends SuperXeats {}

class ShoowLabel extends SuperXeats {}
