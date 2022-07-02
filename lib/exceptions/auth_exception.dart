class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_NOT_FOUND': 'Não há registro correspondente a este e-mail.',
    'INVALID_PASSWORD': 'A senha é inválida.',
    'USER_DISABLED': 'A conta foi desabilitada por um administrador.',
    'EMAIL_EXISTS': 'O endereço de e-mail já está sendo usado por outra conta.',
    'OPERATION_NOT_ALLOWED': 'O login por senha está desabilitado.',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Bloqueamos. Tente mais tarde.',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de autenticão.';
  }
}
