package database;

public class Restaurante {
    private int id;
    private String nome;
    private String endereco;
    private String telefone;
    private String categoria;
    private String horarioFuncionamento;
    private boolean isRetirada;


    public Restaurante(int id, String nome, String endereco, String telefone, String categoria, String horarioFuncionamento, boolean isRetirada) {
        this.id = id;
        this.nome = nome;
        this.endereco = endereco;
        this.telefone = telefone;
        this.categoria = categoria;
        this.horarioFuncionamento = horarioFuncionamento;
        this.isRetirada = isRetirada;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getHorarioFuncionamento() {
        return horarioFuncionamento;
    }

    public void setHorarioFuncionamento(String horarioFuncionamento) {
        this.horarioFuncionamento = horarioFuncionamento;
    }

    public boolean isRetirada() {
        return isRetirada;
    }

    public void setRetirada(boolean isRetirada) {
        this.isRetirada = isRetirada;
    }
}