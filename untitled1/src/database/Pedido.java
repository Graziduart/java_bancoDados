package database;

public class Pedido {
    private int id;
    private String dataPedido; // Alterado de 'date' para 'dataPedido'
    private int idResta;
    private double valor;
    private int idPromo;
    private int idStatusEntrega;
    private int idFormaPag;
    private String obs;
    private double troco;
    private int idEnde;


    public Pedido(int id, String dataPedido, int idResta, double valor, int idPromo, int idStatusEntrega, int idFormaPag, String obs, double troco, int idEnde) {
        this.id = id;
        this.dataPedido = dataPedido;
        this.idResta = idResta;
        this.valor = valor;
        this.idPromo = idPromo;
        this.idStatusEntrega = idStatusEntrega;
        this.idFormaPag = idFormaPag;
        this.obs = obs;
        this.troco = troco;
        this.idEnde = idEnde;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDataPedido() {
        return dataPedido;
    }

    public void setDataPedido(String dataPedido) {
        this.dataPedido = dataPedido;
    }

    public int getIdResta() {
        return idResta;
    }

    public void setIdResta(int idResta) {
        this.idResta = idResta;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public int getIdPromo() {
        return idPromo;
    }

    public void setIdPromo(int idPromo) {
        this.idPromo = idPromo;
    }

    public int getIdStatusEntrega() {
        return idStatusEntrega;
    }

    public void setIdStatusEntrega(int idStatusEntrega) {
        this.idStatusEntrega = idStatusEntrega;
    }

    public int getIdFormaPag() {
        return idFormaPag;
    }

    public void setIdFormaPag(int idFormaPag) {
        this.idFormaPag = idFormaPag;
    }

    public String getObs() {
        return obs;
    }

    public void setObs(String obs) {
        this.obs = obs;
    }

    public double getTroco() {
        return troco;
    }

    public void setTroco(double troco) {
        this.troco = troco;
    }

    public int getIdEnde() {
        return idEnde;
    }

    public void setIdEnde(int idEnde) {
        this.idEnde = idEnde;
    }
}