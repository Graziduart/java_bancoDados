package database;

public class Promocao {
    private int id;
    private String nome;
    private double valor;
    private String codigo;
    private String validade;


    public Promo(int id, String nome, double valor, String codigo, String validade) {
        this.id = id;
        this.nome = nome;
        this.valor = valor;
        this.codigo = codigo;
        this.validade = validade;
    }


}