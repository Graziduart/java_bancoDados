package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Restaurante;

public class RestauranteDAO {
    private Connection connection;

    public RestauranteDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addRestaurante(Restaurante restaurante) {
        String sql = "INSERT INTO restaurante (id, nome, telefone, hora_funcionamento, is_retirada, categoria_id, endereco_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, restaurante.getId());
            stmt.setString(2, restaurante.getNome());
            stmt.setString(3, restaurante.getTelefone());
            stmt.setTime(4, restaurante.getHoraFuncionamento());
            stmt.setString(5, restaurante.getIsRetirada());
            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Restaurante> getRestaurantes() {
        List<Restaurante> restaurantes = new ArrayList<>();
        String sql = "SELECT * FROM restaurante";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Restaurante restaurante = new Restaurante();
                restaurante.setId(rs.getInt("id"));
                restaurante.setNome(rs.getString("nome"));
                restaurante.setTelefone(rs.getString("telefone"));
                restaurante.setHoraFuncionamento(rs.getTime("hora_funcionamento"));
                restaurante.setIsRetirada(rs.getString("is_retirada"));
                restaurantes.add(restaurante);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurantes;
    }

    public void updateRestaurante(Restaurante restaurante) {
        String sql = "UPDATE restaurante SET nome=?, telefone=?, hora_funcionamento=?, is_retirada=?, categoria_id=?, endereco_id=? WHERE id=?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, restaurante.getNome());
            stmt.setString(2, restaurante.getTelefone());
            stmt.setTime(3, restaurante.getHoraFuncionamento());
            stmt.setString(4, restaurante.getIsRetirada());
            stmt.setInt(7, restaurante.getId());
            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteRestaurante(int id) {
        String sql = "DELETE FROM restaurante WHERE id=?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
