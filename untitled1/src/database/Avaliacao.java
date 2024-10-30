package database;

public class Avaliacao {
    private int id;
    private int idPedido;
    private int nota;
    private String comentario;

    public Avaliacao(int id, int idPedido, int nota, String comentario) {
        this.id = id;
        this.idPedido = idPedido;
        this.nota = nota;
        this.comentario = comentario;
    }
}