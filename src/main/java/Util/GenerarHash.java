package Util;

public class GenerarHash {
    public static void main(String[] args) {
        String textoPlano = "12345"; // cambia esto por la clave que quieras migrar
        String hash = PasswordUtil.cifrar(textoPlano);
        System.out.println("Texto plano: " + textoPlano);
        System.out.println("Hash SHA-256: " + hash);
    }
}