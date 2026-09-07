package Util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.UnsupportedEncodingException;

/**
 * Utilidad para cifrar y verificar contraseñas mediante SHA-256.
 *
 * <p>Se usa en el registro (para cifrar antes de guardar) y en el
 * login (para verificar sin necesidad de descifrar, ya que un hash
 * no se puede revertir).</p>
 *
 * @author Santiago
 * @version 1.0
 */
public class PasswordUtil {

    /**
     * Cifra una contraseña en texto plano y devuelve su hash SHA-256
     * en formato hexadecimal.
     *
     * @param passwordTextoPlano Contraseña ingresada por el usuario.
     * @return Hash SHA-256 en hexadecimal (64 caracteres).
     */
    public static String cifrar(String passwordTextoPlano) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(
                    passwordTextoPlano.getBytes("UTF-8")
            );

            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
            throw new RuntimeException("Error al cifrar la contraseña", e);
        }
    }

    /**
     * Verifica si una contraseña en texto plano coincide con un
     * hash previamente almacenado.
     *
     * @param passwordTextoPlano Contraseña ingresada al iniciar sesión.
     * @param hashAlmacenado     Hash guardado en la base de datos.
     * @return true si coinciden, false en caso contrario.
     */
    public static boolean verificar(String passwordTextoPlano, String hashAlmacenado) {
        if (passwordTextoPlano == null || hashAlmacenado == null) {
            return false;
        }
        String hashCalculado = cifrar(passwordTextoPlano);
        return hashCalculado.equals(hashAlmacenado);
    }
}