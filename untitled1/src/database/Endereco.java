package database;

public class Endereco {
    private int id;
    private String rua;
    private String bairro;
    private String cidade;
    private String estado;
    private String cep;
    private String complemento;


    public Endereco(int id, String rua, String bairro, String cidade, String estado, String cep, String complemento) {
        this.id = id;
        this.rua = rua;
        this.bairro = bairro;
        this.cidade = cidade;
        this.estado = estado;
        this.cep = cep;
        this.complemento = complemento;
    }

}