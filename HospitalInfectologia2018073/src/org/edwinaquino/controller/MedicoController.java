package org.edwinaquino.controller;


import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javax.swing.JOptionPane;
import org.edwinaquino.bean.Medico;
import org.edwinaquino.db.Conexion;
import org.edwinaquino.sistema.Principal;


public class MedicoController implements Initializable{

  

    private enum operaciones{Nuevo,Guardar,Editar,Actualizar,Eliminar,Cancelar,Ninguno} 
    private operaciones tipoDeOperaciones = operaciones.Ninguno;
    private ObservableList<Medico> listarMedico;
    
    private Principal escenarioPrincipal;
    @FXML private ComboBox cmbCodigoMedico;
    @FXML private TextField txtNombres;
    @FXML private TextField txtLicenciaMedica;
    @FXML private TextField txtApellidos;
    @FXML private TextField txtSexo;
    @FXML private Button btnAgregar;
    @FXML private Button btnModificar;
    @FXML private Button btnEliminar;
    @FXML private Button btnReporte;
    @FXML private TextField txtEntrada;
    @FXML private TextField txtSalida;
    @FXML private TableView tblMedicos;
    @FXML private TableColumn colCodigoMedico;
    @FXML private TableColumn colLicencia;
    @FXML private TableColumn colNombres;
    @FXML private TableColumn colApellidos;
    @FXML private TableColumn colEntrada;
    @FXML private TableColumn colSalida;
    @FXML private TableColumn colSexo;

    
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        cargarDatos();
       cmbCodigoMedico.setItems(getMedicos());
    }
    
    public void cargarDatos(){
        tblMedicos.setItems(getMedicos());
        colCodigoMedico.setCellValueFactory(new PropertyValueFactory <Medico, Integer>("codigoMedico"));
        colLicencia.setCellValueFactory(new PropertyValueFactory <Medico, Integer>("licenciaMedica"));
        colNombres.setCellValueFactory(new PropertyValueFactory <Medico, String>("nombres"));
        colApellidos.setCellValueFactory(new PropertyValueFactory <Medico, String>("apellidos"));
        colEntrada.setCellValueFactory(new PropertyValueFactory <Medico, Date>("horaEntrada"));
        colSalida.setCellValueFactory(new PropertyValueFactory <Medico, Date>("horaSalida"));
        colSexo.setCellValueFactory(new PropertyValueFactory <Medico, String>("sexo"));
        
    }

    public ObservableList <Medico> getMedicos() {
        ArrayList<Medico> lista = new ArrayList<Medico>();
        
        try{
            PreparedStatement procedimiento = Conexion.getInstancia().getConexion().prepareCall("{call sp_ListarMedicos}");
            ResultSet resultado = procedimiento.executeQuery();
            while(resultado.next()){
                lista.add(new Medico(resultado.getInt("codigoMedico"),
                resultado.getInt("licenciaMedica"),
                resultado.getString("nombres"),
                resultado.getString("apellidos"),
                resultado.getString("horaEntrada"),
                resultado.getString("horaSalida"),
                resultado.getString("sexo")));
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
      return listarMedico = FXCollections.observableList(lista);
    }

    public Medico buscarMedico(int codigoMedico){
        Medico resultado = null;
        try{
            PreparedStatement procedimiento = Conexion.getInstancia().getConexion().prepareCall("{Call sp_Buscar_Medicos (?)}");
            procedimiento.setInt(1, codigoMedico);
            ResultSet registro = procedimiento.executeQuery();
            
        while (registro.next()){
            resultado = new Medico (registro.getInt("codigoMedico"),
            registro.getInt("licenciaMedica"),
            registro.getString("nombres"),
            registro.getString("apellidos"),
            registro.getString("horaEntrada"),
            registro.getString("horaSalida"),
            registro.getString("sexo"));
        }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return resultado;
    }
    
    public void seleccionar(){
        cmbCodigoMedico.getSelectionModel().select(buscarMedico( ((Medico) tblMedicos.getSelectionModel().getSelectedItem()).getCodigoMedico()));
        txtLicenciaMedica.setText(""+((Medico)tblMedicos.getSelectionModel().getSelectedItem()).getLicenciaMedica());
        txtNombres.setText(((Medico)tblMedicos.getSelectionModel().getSelectedItem()).getNombres());
        txtApellidos.setText(((Medico)tblMedicos.getSelectionModel().getSelectedItem()).getApellidos());
        txtSexo.setText(((Medico)tblMedicos.getSelectionModel().getSelectedItem()).getSexo());
        txtEntrada.setText(""+((Medico)tblMedicos.getSelectionModel().getSelectedItem()).getHoraEntrada());
        txtSalida.setText(""+((Medico)tblMedicos.getSelectionModel().getSelectedItem()).getHoraSalida());
    }
    

    
    public void nuevo(){
        switch(tipoDeOperaciones){
            case  Ninguno:
                activar();
                limpiar();
                tipoDeOperaciones = operaciones.Guardar;
                btnAgregar.setText("Guardar");
                btnEliminar.setText("Cancelar");
                btnModificar.setDisable(true);
                btnReporte.setDisable(true);
                break;
            case Guardar:
                ingresar();
                desactivar();
                btnAgregar.setText("Nuevo");
                btnEliminar.setText("Eliminar");
                btnModificar.setDisable(false);
                btnReporte.setDisable(false);
                tipoDeOperaciones = operaciones.Ninguno;
                cargarDatos();
                break;
        }
    
    }

    
    private void activar() {
        cmbCodigoMedico.setDisable(false);
        txtNombres.setDisable(false);
        txtApellidos.setDisable(false);
        txtLicenciaMedica.setDisable(false);
        txtEntrada.setDisable(false);
        txtSalida.setDisable(false);
        txtSexo.setDisable(false);
        
        cmbCodigoMedico.setEditable(true);
        txtNombres.setEditable(true);
        txtApellidos.setEditable(true);
        txtLicenciaMedica.setEditable(true);
        txtSexo.setEditable(true);
        
        
    }

    private void limpiar() {
       txtLicenciaMedica.setText("");
       txtNombres.setText("");
       txtApellidos.setText("");
       txtSexo.setText("");
    }
    
    private void ingresar() {
       Medico registro = new Medico();
       registro.setLicenciaMedica(Integer.parseInt(txtLicenciaMedica.getText()));
       registro.setNombres(txtNombres.getText());
       registro.setApellidos(txtApellidos.getText());
       registro.setHoraEntrada(txtEntrada.getText());
       registro.setHoraSalida(txtSalida.getText());
       registro.setSexo(txtSexo.getText());
       
       try{
          PreparedStatement procedimiento = Conexion.getInstancia().getConexion().prepareCall("{call sp_addMedicos (?,?,?,?,?,?)}"); 
          procedimiento.setInt(1,registro.getLicenciaMedica());
          procedimiento.setString(2,registro.getNombres());
          procedimiento.setString(3,registro.getApellidos());
          procedimiento.setString(4,registro.getHoraEntrada());
          procedimiento.setString(5,registro.getHoraSalida());
          procedimiento.setString(6, registro.getSexo());
          procedimiento.execute();
          listarMedico.add(registro);
       }catch(SQLException e){
       
           e.printStackTrace();
           
       }
       
        
    }

    private void desactivar() {
        cmbCodigoMedico.setDisable(true);
        txtNombres.setDisable(true);
        txtApellidos.setDisable(true);
        txtLicenciaMedica.setDisable(true);
        txtEntrada.setDisable(true);
        txtSalida.setDisable(true);
        txtSexo.setDisable(true);
        
        cmbCodigoMedico.setEditable(false);
        txtNombres.setEditable(false);
        txtApellidos.setEditable(false);
        txtLicenciaMedica.setEditable(false);
        txtSexo.setEditable(false);
    }
    
    
      private void actualizar() throws SQLException {
        PreparedStatement procedimiento = Conexion.getInstancia().getConexion().prepareCall("{call sp_ModificarMedicos (?,?,?,?,?,?,?)}");
        Medico registro= (Medico) tblMedicos.getSelectionModel().getSelectedItem();
        registro.setCodigoMedico(Integer.parseInt(cmbCodigoMedico.getSelectionModel().getSelectedItem().toString()));
        registro.setLicenciaMedica(Integer.parseInt(txtLicenciaMedica.getText()));
        registro.setNombres(txtNombres.getText());
        registro.setApellidos(txtApellidos.getText());
        registro.setHoraEntrada(txtEntrada.getText());
        registro.setHoraSalida(txtSalida.getText());
        registro.setSexo(txtSexo.getText());
        
        procedimiento.setInt(1,registro.getCodigoMedico());
        procedimiento.setInt(2,registro.getLicenciaMedica());
        procedimiento.setString(3,registro.getNombres());
        procedimiento.setString(4,registro.getApellidos());
        procedimiento.setString(5,registro.getHoraEntrada());
        procedimiento.setString(6,registro.getHoraSalida());
        procedimiento.setString(7, registro.getSexo());
        procedimiento.execute();
        listarMedico.add(registro);
        
    }
    
    
    public void editar() throws SQLException{
        switch(tipoDeOperaciones){
            case Ninguno:
                if (tblMedicos.getSelectionModel().getSelectedItem() != null){
                    btnModificar.setText("Actualizar");
                    btnReporte.setText("Cancelar");
                    tipoDeOperaciones = operaciones.Actualizar;
                    btnAgregar.setDisable(true);
                    btnEliminar.setDisable(true);
                    activar();
                }
                break;
            
            case Actualizar:
                 actualizar();
                 btnModificar.setText("Editar");
                 btnReporte.setText("Reportar");
                 btnAgregar.setDisable(false);
                 btnEliminar.setDisable(false);
                 desactivar();
                 cargarDatos();
                 tipoDeOperaciones = operaciones.Ninguno;
                
        }

    
    }
    
    public void Eliminar(){
        if(tipoDeOperaciones == operaciones.Guardar){
            cancelar();
        }else{
            tipoDeOperaciones = operaciones.Eliminar;
        if(tblMedicos.getSelectionModel().getSelectedItem() != null){
            int respuesta = JOptionPane.showConfirmDialog(null, "seguro que desea eliminar el registro?","Eliminar Medico",JOptionPane.YES_NO_OPTION,JOptionPane.QUESTION_MESSAGE);
            if(respuesta == JOptionPane.YES_OPTION){
                try{
                    PreparedStatement procedimiento = Conexion.getInstancia().getConexion().prepareCall("{call sp_EliminarMedicos(?)}");
                    procedimiento.setInt(1,((Medico) tblMedicos.getSelectionModel().getSelectedItem()).getCodigoMedico());
                    procedimiento.execute();
                    listarMedico.remove(tblMedicos.getSelectionModel().getSelectedIndex());
                    limpiar();
                    cargarDatos();
                    tipoDeOperaciones = operaciones.Ninguno;
                }catch(SQLException e){
                    e.printStackTrace();
                }
            }
        }
        
            
        else{
            JOptionPane.showMessageDialog(null, "debe seleccionar un registro a eliminar");
        }
        }
    }
    
    public void cancelar(){
        btnAgregar.setText("Nuevo");
        btnEliminar.setText("Eliminar");
        btnReporte.setDisable(false);
        btnModificar.setDisable(false);
    }
    

    
    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    
    public void menuPrincipal(){
        escenarioPrincipal.menuPrincipal();
   } 
    
    public void ventanaTelefonoMedico(){
        escenarioPrincipal.ventanaTelefonoMedico();
    }
    
    
    
    
}
