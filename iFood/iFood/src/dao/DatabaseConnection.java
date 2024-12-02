package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/mydb"; // Substitua "mydb" pelo nome do seu banco de dados
    private static final String USER = "root"; // Usuário padrão do MySQL
    private static final String PASSWORD = ""; // Senha padrão do MySQL (geralmente vazia para configuração local)
    private static Connection connection = null;

    public static Connection getConnection() throws SQLException {
        if (connection == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Driver MySQL
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
        return connection;
    }
}

