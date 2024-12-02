package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Endereco;

public class EnderecoDAO {
    private Connection connection;

    public EnderecoDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addEndereco(Endereco endereco) {
        String sql = "INSERT INTO endereco (id, rua, numero, bairro, referencia, cidade, cep, uf) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, endereco.getId());
            stmt.setString(2, endereco.getRua());
            stmt.setInt(3, endereco.getNumero());
            stmt.setString(4, endereco.getBairro());
            stmt.setString(5, endereco.getReferencia());
            stmt.setString(6, endereco.getCidade());
            stmt.setString(7, endereco.getCep());
            stmt.setString(8, endereco.getUf());
            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Endereco> getEnderecos() {
        List<Endereco> enderecos = new ArrayList<>();
        String sql = "SELECT * FROM endereco";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Endereco endereco = new Endereco();
                endereco.setId(rs.getInt("id"));
                endereco.setRua(rs.getString("rua"));
                endereco.setNumero(rs.getInt("numero"));
                endereco.setBairro(rs.getString("bairro"));
                endereco.setReferencia(rs.getString("referencia"));
                endereco.setCidade(rs.getString("cidade"));
                endereco.setCep(rs.getString("cep"));
                endereco.setUf(rs.getString("uf"));
                enderecos.add(endereco);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enderecos;
    }

    public void updateEndereco(Endereco endereco) {
        String sql = "UPDATE endereco SET rua=?, numero=?, bairro=?, referencia=?, cidade=?, cep=?, uf=? WHERE id=?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, endereco.getRua());
            stmt.setInt(2, endereco.getNumero());
            stmt.setString(3, endereco.getBairro());
            stmt.setString(4, endereco.getReferencia());
            stmt.setString(5, endereco.getCidade());
            stmt.setString(6, endereco.getCep());
            stmt.setString(7, endereco.getUf());
            stmt.setInt(8, endereco.getId());
            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteEndereco(int id) {
        String sql = "DELETE FROM endereco WHERE id=?";
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
