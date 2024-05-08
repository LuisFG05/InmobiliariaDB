package conection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;

public class Consultas {
    
    public void ConsultarUsuario(String user, String pass) {
        conectionSQL conexion = new conectionSQL();
        try {
            // Establecer la conexión
            conexion.conectar();
            
            String passCorrecto = null;

            PreparedStatement pst = conexion.conectar().prepareStatement("SELECT authentication_string FROM mysql.user WHERE User = ?");
            pst.setString(1, user); // Establecer el nombre de usuario como parámetro en la consulta
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                passCorrecto = rs.getString("authentication_string");

                if (pass.equals(passCorrecto)) {
                    JOptionPane.showMessageDialog(null, "Login Correcto Bienvenido " + user);
                } else {
                    JOptionPane.showMessageDialog(null, "Usuario o contraseña incorrectos");
                }
            } else {
                JOptionPane.showMessageDialog(null, "Usuario no encontrado");
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
        } finally {
            // Cerrar la conexión
            conexion.Desconectar();
        }
    }
}
