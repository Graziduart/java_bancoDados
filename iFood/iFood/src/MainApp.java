import dao.*;
import modelo.*;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusAdapter;
import java.awt.event.FocusEvent;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static dao.DatabaseConnection.getConnection;

public class MainApp {
    public static void main(String[] args) {
        // Criação da janela principal
        JFrame frame = new JFrame("Sistema iFood");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);

        // Barra de menu
        JMenuBar menuBar = new JMenuBar();
        JMenu menu = new JMenu("Pedidos");
        JMenuItem menuItemPedido = new JMenuItem("Fazer Pedido");

        // Adiciona item ao menu
        menu.add(menuItemPedido);
        menuBar.add(menu);
        frame.setJMenuBar(menuBar);

        // Define a ação para o item de menu "Fazer Pedido"
        menuItemPedido.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                realizarPedido();
            }
        });

        frame.setVisible(true);
    }

    private static void realizarPedido() {
        try {
            // Conexão com o banco de dados
            Connection connection = getConnection();

            // Listagem de restaurantes
            List<Restaurante> restaurantes = new RestauranteDAO().getRestaurantes();
            String[] restaurantesArray = restaurantes.stream()
                    .map(Restaurante::getNome)
                    .toArray(String[]::new);

            String restauranteSelecionado = (String) JOptionPane.showInputDialog(
                    null,
                    "Selecione um restaurante:",
                    "Restaurantes",
                    JOptionPane.QUESTION_MESSAGE,
                    null,
                    restaurantesArray,
                    restaurantesArray[0]
            );

            if (restauranteSelecionado != null) {
                int restauranteId = restaurantes.stream()
                        .filter(r -> r.getNome().equals(restauranteSelecionado))
                        .findFirst()
                        .map(Restaurante::getId)
                        .orElse(-1);

                // Listagem de produtos do restaurante selecionado
                List<Produto> produtos = new ProdutoDAO().getProdutosByRestaurante(restauranteId);
                List<Produto> produtosSelecionados = new ArrayList<>();

                boolean adicionarMaisProdutos;
                do {
                    String[] produtosArray = produtos.stream()
                            .map(Produto::getNome)
                            .toArray(String[]::new);
                    String produtoSelecionado = (String) JOptionPane.showInputDialog(
                            null,
                            "Selecione um produto de " + restauranteSelecionado + ":",
                            "Produtos",
                            JOptionPane.QUESTION_MESSAGE,
                            null,
                            produtosArray,
                            produtosArray[0]
                    );

                    if (produtoSelecionado != null) {
                        produtos.stream()
                                .filter(p -> p.getNome().equals(produtoSelecionado))
                                .findFirst()
                                .ifPresent(produtosSelecionados::add);

                        adicionarMaisProdutos = JOptionPane.showConfirmDialog(
                                null,
                                "Deseja adicionar mais um produto?",
                                "Adicionar Produto",
                                JOptionPane.YES_NO_OPTION
                        ) == JOptionPane.YES_OPTION;
                    } else {
                        adicionarMaisProdutos = false;
                    }
                } while (adicionarMaisProdutos);

                // Listar todos os produtos adicionados com o nome do restaurante
                BigDecimal total = BigDecimal.ZERO;
                StringBuilder resumo = new StringBuilder("Restaurante: " + restauranteSelecionado + "\n\nVocê adicionou os seguintes produtos:\n");
                for (Produto produto : produtosSelecionados) {
                    resumo.append(produto.getNome())
                            .append(" - R$ ")
                            .append(String.format("%.2f", produto.getPreco()))
                            .append("\n");
                    total = total.add(produto.getPreco());
                }
                resumo.append("\nTotal: R$ ").append(String.format("%.2f", total));

                JOptionPane.showMessageDialog(
                        null,
                        resumo.toString(),
                        "Resumo do Pedido",
                        JOptionPane.INFORMATION_MESSAGE
                );

                 // Solicitar endereço de entrega
                JPanel panelEndereco = new JPanel();
                JTextField textFieldCep = new JTextField(10);
                JTextField textFieldRua = new JTextField(20);
                JTextField textFieldNumero = new JTextField(5);
                JTextField textFieldBairro = new JTextField(20);
                JTextField textFieldReferencia = new JTextField(20);
                JTextField textFieldCidade = new JTextField(20);
                JTextField textFieldUf = new JTextField(2);

                panelEndereco.setLayout(new BoxLayout(panelEndereco, BoxLayout.Y_AXIS));
                panelEndereco.add(new JLabel("CEP:"));
                panelEndereco.add(textFieldCep);
                panelEndereco.add(new JLabel("Rua:"));
                panelEndereco.add(textFieldRua);
                panelEndereco.add(new JLabel("Número:"));
                panelEndereco.add(textFieldNumero);
                panelEndereco.add(new JLabel("Bairro:"));
                panelEndereco.add(textFieldBairro);
                panelEndereco.add(new JLabel("Referência:"));
                panelEndereco.add(textFieldReferencia);
                panelEndereco.add(new JLabel("Cidade:"));
                panelEndereco.add(textFieldCidade);
                panelEndereco.add(new JLabel("UF:"));
                panelEndereco.add(textFieldUf);

                textFieldCep.addFocusListener(new FocusAdapter() {
                    @Override
                    public void focusLost(FocusEvent e) {
                        String cep = textFieldCep.getText();
                        if (cep.length() == 8) {
                            try {
                                String jsonResponse = ViaCepClient.buscarEnderecoPorCep(cep);
                                String localidade = "";
                                String uf = "";

                                if (jsonResponse != null) {
                                    localidade = ViaCepClient.extractValueFromJson(jsonResponse, "localidade");
                                    uf = ViaCepClient.extractValueFromJson(jsonResponse, "uf");
                                } else {
                                    System.out.println("Não foi possível obter informações para o CEP fornecido.");
                                }
                                textFieldCidade.setText(localidade);
                                textFieldUf.setText(uf);
                            } catch (Exception ex) {
                                ex.printStackTrace();
                                JOptionPane.showMessageDialog(null, "Erro ao consultar o CEP");
                            }
                        }
                    }
                });

                int result = JOptionPane.showConfirmDialog(
                        null,
                        panelEndereco,
                        "Informe o Endereço de Entrega",
                        JOptionPane.OK_CANCEL_OPTION,
                        JOptionPane.PLAIN_MESSAGE
                );

                if (result == JOptionPane.OK_OPTION) {
                    String rua = textFieldRua.getText();
                    int numero = Integer.parseInt(textFieldNumero.getText());
                    String bairro = textFieldBairro.getText();
                    String referencia = textFieldReferencia.getText();
                    String cidade = textFieldCidade.getText();
                    String cep = textFieldCep.getText();
                    String uf = textFieldUf.getText();

                    // Criar objeto Endereco para ser utilizado mais a frente
                    Endereco enderecoEntrega = new Endereco();
                    enderecoEntrega.setRua(rua);
                    enderecoEntrega.setNumero(numero);
                    enderecoEntrega.setBairro(bairro);
                    enderecoEntrega.setReferencia(referencia);
                    enderecoEntrega.setCidade(cidade);
                    enderecoEntrega.setCep(cep);
                    enderecoEntrega.setUf(uf);

                    JOptionPane.showMessageDialog(
                            null,
                            "Endereço informado:\n" +
                                    "Rua: " + rua + "\nNúmero: " + numero + "\nBairro: " + bairro +
                                    "\nReferência: " + referencia + "\nCidade: " + cidade +
                                    "\nCEP: " + cep + "\nUF: " + uf,
                            "Endereço de Entrega",
                            JOptionPane.INFORMATION_MESSAGE
                    );

                    // Listagem das formas de pagamentos
                    List<FormaPagamento> pagamentos = new FormaPagamentoDAO().getFormasPagamento();
                    String[] formaPagamentosArray = pagamentos.stream()
                            .map(FormaPagamento::getTipoDePagamento)
                            .toArray(String[]::new);

                    String formaPagamentoSelecionada = (String) JOptionPane.showInputDialog(
                            null,
                            "Selecione uma forma de pagamento:",
                            "Forma de pagamento",
                            JOptionPane.QUESTION_MESSAGE,
                            null,
                            formaPagamentosArray,
                            formaPagamentosArray[0]
                    );

                    JOptionPane.showMessageDialog(
                            null,
                            "Seu pedido processado e irá para o setor de produção.\n\n" +
                                    "Endereço para entrega: " + enderecoEntrega.getRua() + ", " + enderecoEntrega.getNumero() +
                                    " - " + enderecoEntrega.getBairro() + "\n" + enderecoEntrega.getCidade() + " - "
                                    + enderecoEntrega.getUf() + " - CEP: " + enderecoEntrega.getCep() + "\n\nResumo pagamento:\n"
                                    + "Restaurante escolhido: " + restauranteSelecionado + "\nValor a ser pago: " + total +
                                    "\nForma de pagamento: " + formaPagamentoSelecionada,
                            "Resumo do pedido",
                            JOptionPane.INFORMATION_MESSAGE
                    );

                    String[] mensagens = { "Produção", "Saiu para entrega", "Entregue" };

                    // Criando uma thread para alternar mensagens
                    Thread thread = new Thread(() -> {
                        int contador = 0;
                        while (true) {
                            JOptionPane.showMessageDialog(null, mensagens[contador % mensagens.length]);
                            contador++;
                            try {
                                // Aguarda 2 segundos antes de mostrar a próxima mensagem
                                Thread.sleep(2000);
                                if(contador == 3) {
                                    Thread.currentThread().interrupt();
                                    break;
                                }
                            } catch (InterruptedException e) {
                                Thread.currentThread().interrupt();
                                break;
                            }
                        }
                    });

                    // Iniciando a thread
                    thread.start();
                    
                }
            }
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
