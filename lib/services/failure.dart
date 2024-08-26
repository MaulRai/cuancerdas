class SignUpWithEmailAndPassFailure {
  final String message;

  const SignUpWithEmailAndPassFailure(
      [this.message = "An unknown error occured"]);
  factory SignUpWithEmailAndPassFailure.code(String code) {
    switch (code) {
      case 'weak_password':
        return SignUpWithEmailAndPassFailure('Please enter a stronger password.');
      case 'invalid-email':
        return SignUpWithEmailAndPassFailure('Email is not vald or badly formatted.');
      case 'email-already-in-use':
        return SignUpWithEmailAndPassFailure('An account already exists for that email.');
      case 'operation-not-allowed':
        return SignUpWithEmailAndPassFailure('Operation not allowed. Please contact support.');
      case 'user-disabled':
        return SignUpWithEmailAndPassFailure('This user has been disabled. Please contact support for help.');
      default:
        return const SignUpWithEmailAndPassFailure();
    }
  }
}
