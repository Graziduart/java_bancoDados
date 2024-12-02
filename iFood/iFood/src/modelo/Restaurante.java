package modelo;

import java.sql.Time;

public class Restaurante {
    private int id;
    private String nome;
    private String telefone;
    private Time horaFuncionamento;
    private String isRetirada;

    // Getters e Setters

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

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public Time getHoraFuncionamento() {
        return horaFuncionamento;
    }

    public void setHoraFuncionamento(Time horaFuncionamento) {
        this.horaFuncionamento = horaFuncionamento;
    }

    public String getIsRetirada() {
        return isRetirada;
    }

    public void setIsRetirada(String isRetirada) {
        this.isRetirada = isRetirada;
    }
}
