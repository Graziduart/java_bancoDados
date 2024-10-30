package database;

public class PedidoProdutoAcompanhamento {
    private int idPedidoProduto;
    private int idAcomp;


    public PedidoProdutoAcompanhamento(int idPedidoProduto, int idAcomp) {
        this.idPedidoProduto = idPedidoProduto;
        this.idAcomp = idAcomp;
    }

    public int getIdPedidoProduto() {
        return idPedidoProduto;
    }

    public void setIdPedidoProduto(int idPedidoProduto) {
        this.idPedidoProduto = idPedidoProduto;
    }

    public int getIdAcomp() {
        return idAcomp;
    }

    public void setIdAcomp(int idAcomp) {
        this.idAcomp = idAcomp;
    }
}