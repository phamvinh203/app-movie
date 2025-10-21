import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthApiService {
  Future<User> signUp(String email, String password);
  Future<User> signIn(String email, String password);
  Future<void> signOut();
}

class AuthApiServiceImpl extends AuthApiService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw Exception('Failed to create user');
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('An error occurred during sign up: ${e.toString()}');
    }
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw Exception('Failed to sign in');
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('An error occurred during sign in: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  String _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Mật khẩu quá yếu.';
      case 'email-already-in-use':
        return 'Đã có tài khoản sử dụng email này.';
      case 'invalid-email':
        return 'Địa chỉ email không hợp lệ.';
      case 'user-not-found':
        return 'Không tìm thấy tài khoản với email này.';
      case 'wrong-password':
        return 'Mật khẩu không đúng.';
      case 'user-disabled':
        return 'Tài khoản này đã bị vô hiệu hóa.';
      case 'too-many-requests':
        return 'Quá nhiều yêu cầu. Vui lòng thử lại sau.';
      case 'operation-not-allowed':
        return 'Đăng nhập bằng email/mật khẩu chưa được cho phép.';
      default:
        // Some Firebase exceptions may not set a specific code but provide an
        // English message (e.g. "The supplied auth credential is incorrect, malformed or has expired.").
        // Normalize those messages to a unified Vietnamese message for wrong credentials.
        final lowerMsg = e.message?.toLowerCase() ?? '';
        if (lowerMsg.contains('supplied auth credential is incorrect') ||
            lowerMsg.contains('malformed') ||
            lowerMsg.contains('has expired') ||
            lowerMsg.contains('wrong password') ||
            lowerMsg.contains('invalid password') ||
            lowerMsg.contains('no user record') ||
            lowerMsg.contains('no user') ||
            lowerMsg.contains('user-not-found') ||
            lowerMsg.contains('invalid credential')) {
          return 'Tài khoản hoặc mật khẩu không đúng.';
        }

        return 'Thông tin xác thực không hợp lệ hoặc đã xảy ra lỗi xác thực.';
    }
  }
}
