import 'package:erni_mobile/domain/services/authentication/token/jwt_decoder.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart' as jwtd;

@LazySingleton(as: JwtDecoder)
class JwtDecoderImpl implements JwtDecoder {
  @override
  String getEmail(String jwt) {
    const emailClaimsKey = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress';
    final data = _decode(jwt);

    if (data.containsKey(emailClaimsKey)) {
      return data[emailClaimsKey].toString();
    }

    throw UnsupportedError('Cannot find claims key `$emailClaimsKey`');
  }

  @override
  String getId(String jwt) {
    const idClaimsKey = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier';
    final data = _decode(jwt);

    if (data.containsKey(idClaimsKey)) {
      return data[idClaimsKey].toString();
    }

    throw UnsupportedError('Cannot find claims key `$idClaimsKey`');
  }

  static Map<String, Object> _decode(String jwt) => jwtd.JwtDecoder.decode(jwt).cast();
}
