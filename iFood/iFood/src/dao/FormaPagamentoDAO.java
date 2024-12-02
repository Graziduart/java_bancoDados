package dao;

import modelo.FormaPagamento;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FormaPagamentoDAO {
    private Connection connection;

    public FormaPagamentoDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<FormaPagamento> getFormasPagamento() {
        List<FormaPagamento> formasPagamento = new ArrayList<>();
        String sql = "SELECT id, tipo_de_pagamento FROM forma_pagamento";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                FormaPagamento formaPagamento = new FormaPagamento();
                formaPagamento.setId(rs.getInt("id"));
                formaPagamento.setTipoDePagamento(rs.getString("tipo_de_pagamento"));
                formasPagamento.add(formaPagamento);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return formasPagamento;
    }
}
