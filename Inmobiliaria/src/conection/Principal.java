/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conection;

import Formularios.frmLogin;

/**
 *
 * @author luill
 */

/**Método para llamar la conexión de la DB*/
public class Principal {
    public static void main(String[] args) {
        conectionSQL conexion = new conectionSQL();
        conexion.conectar();
    
        
       java.awt.EventQueue.invokeLater(() -> {
           frmLogin login = new frmLogin(null, true); // Crea una instancia de tu formulario
           login.setVisible(true); // Hacer visible el formulario
        });
    }
}

