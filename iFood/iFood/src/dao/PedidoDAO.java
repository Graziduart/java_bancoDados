package dao;

import modelo.Pedido;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PedidoDAO {
    private Connection connection;

    public PedidoDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addPedido(Pedido pedido) {
        String sql = "INSERT INTO pedido (data_criacao, restaurante_id, total, promocao_id, status_id, forma_pagamento_id, observacao, valor_troco, endereco_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setDate(1, new Date(pedido.getDataCriacao().getTime()));
            stmt.setInt(2, pedido.getRestauranteId());
            stmt.setDouble(3, pedido.getTotal());
            stmt.setInt(4, pedido.getPromocaoId());
            stmt.setInt(5, pedido.getStatusId());
            stmt.setInt(6, pedido.getFormaPagamentoId());
            stmt.setString(7, pedido.getObservacao());
            stmt.setDouble(8, pedido.getValorTroco());
            stmt.setInt(9, pedido.getEnderecoId());
            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Pedido> getPedidos() {
        List<Pedido> pedidos = new ArrayList<>();
        String sql = "SELECT * FROM pedido";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Pedido pedido = new Pedido();
                pedido.setPedidoId(rs.getInt("pedido_id"));
                pedido.setDataCriacao(rs.getDate("data_criacao"));
                pedido.setRestauranteId(rs.getInt("restaurante_id"));
                pedido.setTotal(rs.getDouble("total"));
                pedido.setPromocaoId(rs.getInt("promocao_id"));
                pedido.setStatusId(rs.getInt("status_id"));
                pedido.setFormaPagamentoId(rs.getInt("forma_pagamento_id"));
                pedido.setObservacao(rs.getString("observacao"));
                pedido.setValorTroco(rs.getDouble("valor_troco"));
                pedido.setEnderecoId(rs.getInt("endereco_id"));
                pedidos.add(pedido);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pedidos;
    }

    public void updatePedido(Pedido pedido) {
        String sql = "UPDATE pedido SET data_criacao=?, restaurante_id=?, total=?, promocao_id=?, status_id=?, forma_pagamento_id=?, observacao=?, valor_troco=?, endereco_id=? WHERE pedido_id=?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setDate(1, new Date(pedido.getDataCriacao().getTime()));
            stmt.setInt(2, pedido.getRestauranteId());
            stmt.setDouble(3, pedido.getTotal());
            stmt.setInt(4, pedido.getPromocaoId());
            stmt.setInt(5, pedido.getStatusId());
            stmt.setInt(6, pedido.getFormaPagamentoId());
            stmt.setString(7, pedido.getObservacao());
            stmt.setDouble(8, pedido.getValorTroco());
            stmt.setInt(9, pedido.getEnderecoId());
            stmt.setInt(10, pedido.getPedidoId());
            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deletePedido(int pedidoId) {
        String sql = "DELETE FROM pedido WHERE pedido_id=?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, pedidoId);
            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
