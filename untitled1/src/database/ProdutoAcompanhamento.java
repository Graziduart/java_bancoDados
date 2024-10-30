package database;

public class ProdutoAcompanhamento {
    private int idProduto;
    private int idAcompanhamento;

    public ProdutoAcompanhamento(int idProduto, int idAcompanhamento) {
        this.idProduto = idProduto;
        this.idAcompanhamento = idAcompanhamento;
    }

    public int getIdProduto() {
        return idProduto;
    }

    public void setIdProduto(int idProduto) {
        this.idProduto = idProduto;
    }

    public int getIdAcompanhamento() {
        return idAcompanhamento;
    }

    public void setIdAcompanhamento(int idAcompanhamento) {
        this.idAcompanhamento = idAcompanhamento;
    }
}