
package org.edwinaquino.sistema;

import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import org.edwinaquino.controller.ContactoUrgenciasController;
import org.edwinaquino.controller.MenuPrincipalController;
import org.edwinaquino.controller.MedicoController;
import org.edwinaquino.controller.PacientesController;
import org.edwinaquino.controller.ProgramadorController;
import org.edwinaquino.controller.TelefonoMedicoController;
import org.edwinaquino.db.Conexion;

/**
 *
 * @author programacion
 */
public class Principal extends Application {
    private final String PAQUETE_VISTA = "/org/edwinaquino/view/";
    private Stage escenarioPrincipal;
    private Scene escena;
    @Override
    public void start(Stage escenarioPrincipal) throws Exception {
        
       try{
        PreparedStatement procedimiento = Conexion.getInstancia().getConexion().prepareCall("{call sp_Buscar_Medicos(?)}");
        procedimiento.setInt(1,1);
        ResultSet registro = procedimiento.executeQuery();
        while(registro.next()){
            System.out.println(registro.getInt("codigoMedico"));
            System.out.println(registro.getInt("licenciaMedica"));
        }
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        this.escenarioPrincipal = escenarioPrincipal;
        escenarioPrincipal.setTitle("Hospital de Infectologia");
        menuPrincipal();
        escenarioPrincipal.show();
        
        
    }
    public void menuPrincipal(){
        try{
            MenuPrincipalController menuPrincipal = (MenuPrincipalController)cambiarEscena("MenuPrincipalView.fxml",630,472);
            menuPrincipal.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
        
    }
    public void ventanaMedicos (){
        try{
           MedicoController medicoController = (MedicoController)cambiarEscena("MedicosView.fxml",734,558);
           medicoController.setEscenarioPrincipal(this);
           
            }catch(Exception e){
            e.printStackTrace();
        }
    
    }
    public void ventanaProgramador (){
        try{
           ProgramadorController programadorController = (ProgramadorController)cambiarEscena("Programador.fxml",691,459);
           programadorController.setEscenarioPrincipal(this);
           
            }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaPacientes (){
        try{
           PacientesController pacientesController = (PacientesController)cambiarEscena("PacientesView.fxml",802,507);
           pacientesController.setEscenarioPrincipal(this);
           
            }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaTelefonoMedico (){
        try{
           TelefonoMedicoController telefonoController = (TelefonoMedicoController)cambiarEscena("TelefonosMedicosView.fxml",600,400);
           telefonoController.setEscenarioPrincipal(this);
           
            }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaContactoUrgencias (){
        try{
           ContactoUrgenciasController urgenciasController = (ContactoUrgenciasController)cambiarEscena("ContactoUrenciaView.fxml",656,500);
           urgenciasController.setEscenarioPrincipal(this);
           
            }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public Initializable cambiarEscena(String fxml, int ancho, int alto)throws Exception{
        Initializable resultado = null;
        FXMLLoader cargadorFXML = new FXMLLoader();
        InputStream archivo = Principal.class.getResourceAsStream(PAQUETE_VISTA+fxml);
        cargadorFXML.setBuilderFactory(new JavaFXBuilderFactory());
        cargadorFXML.setLocation(Principal.class.getResource(PAQUETE_VISTA+fxml));
        escena = new Scene((AnchorPane)cargadorFXML.load(archivo),ancho,alto);
        escenarioPrincipal.setScene(escena);
        escenarioPrincipal.sizeToScene();
        resultado = (Initializable)cargadorFXML.getController();
        return resultado;
    }
    
    
    public static void main(String[] args) {
    launch(args);
    }

    
} 

    
    
