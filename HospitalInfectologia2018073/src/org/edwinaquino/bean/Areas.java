
package org.edwinaquino.bean;


public class Areas {
    private int codigoArea;
    private int nombreArea;

    public Areas(int codigoArea, int nombreArea) {
        this.codigoArea = codigoArea;
        this.nombreArea = nombreArea;
    }

    public Areas() {
    }

    public int getCodigoArea() {
        return codigoArea;
    }

    public void setCodigoArea(int codigoArea) {
        this.codigoArea = codigoArea;
    }

    public int getNombreArea() {
        return nombreArea;
    }

    public void setNombreArea(int nombreArea) {
        this.nombreArea = nombreArea;
    } 
}
