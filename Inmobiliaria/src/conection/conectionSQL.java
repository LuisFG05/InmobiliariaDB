/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author luill
 */
public class conectionSQL {
    
    String bd = "inmobiliaria";
    String url = "jdbc:mysql://localhost:3306/";
    String user = "root";
    String password = "2052003";
    String driver = "com.mysql.cj.jdbc.Driver";
    Connection cx;

    public conectionSQL(){
    }
    
    public Connection conectar(){
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(conectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            cx=DriverManager.getConnection(url+bd,user,password);
            System.out.println("Se conectó");
        } catch (SQLException ex) {
            System.out.println("No se pudo");
            Logger.getLogger(conectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cx;
         
    }
    
    public void Desconectar(){
        try {
            cx.close();
        } catch (SQLException ex) {
            Logger.getLogger(conectionSQL.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    // Aquí puedes agregar métodos para realizar operaciones con la base de datos
    
    
}

