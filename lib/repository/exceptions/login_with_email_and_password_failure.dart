class LogInWithEmailAndPasswordFailure {
  final String message;

  const LogInWithEmailAndPasswordFailure(
      [this.message = 'An Unknown error occurred']);

  factory LogInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted');
      case 'operatin-not-allowed':
        return const LogInWithEmailAndPasswordFailure(
            'Opearation is not allowed. Please contact support.');
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
            'This user has been disabled. Please contact support for help.');
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}
