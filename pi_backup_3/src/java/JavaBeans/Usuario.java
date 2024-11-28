package JavaBeans;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Usuario extends Conexao {

    public int pkuser;
    public String nome;
    public String idade;
    public String email;
    public String senha;

    public boolean checarLogin() {
        try {
            sql = "select * from usuarios where email = ? and senha = ?";
            ps = con.prepareStatement(sql); // prepara SQL
            ps.setString(1, email); // Configura Parametros
            ps.setString(2, senha); // Configura Parametros
            tab = ps.executeQuery(); // Executa comando SQL
            if (tab.next()) {
                this.pkuser = tab.getInt("pkuser");  // Pega a chave primária do usuário
                this.nome = tab.getString("nome");
                this.email = tab.getString("email");
                this.senha = tab.getString("senha");
                return true;
            }
            this.statusSQL = null; // armazena null se deu tudo certo
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao tentar buscar Usuário! Tente novamente! " + ex.getMessage();
        }
        return false;
    }

    public void incluir() {
        try {
            sql = "insert into usuarios (pkuser, nome, idade, email, senha) " + "values (?,?,?,?,?) ";
            ps = con.prepareStatement(sql);
            ps.setInt(1, pkuser);
            ps.setString(2, nome);
            ps.setString(3, idade);
            ps.setString(4, email);
            ps.setString(5, senha);
            ps.executeUpdate();
            this.statusSQL = null;
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao incluir usuario! Tente novamente mais tarde! <br> " + ex.getMessage();
        }
    }

    public boolean atualizarDados() {
        sql = "UPDATE usuarios SET ";
        boolean hasField = false;

        if (this.nome != null) {
            sql += "nome = ?, ";
            hasField = true;
        }
        if (this.idade != null) {
            sql += "idade = ?, ";
            hasField = true;
        }
        if (this.email != null) {
            sql += "email = ?, ";
            hasField = true;
        }
        if (this.senha != null) {
            sql += "senha = ? ";
            hasField = true;
        }

        sql = sql.trim();
        if (sql.endsWith(",")) {
            sql = sql.substring(0, sql.length() - 1);
        }

        sql += " WHERE pkuser = ?";

        if (!hasField) {
            return false; // Sem campos para atualizar
        }

        try (PreparedStatement ps= con.prepareStatement(sql)) {
            int index = 1;
            if (this.nome != null) {
                ps.setString(index++, this.nome);
            }
            if (this.idade != null) {
                ps.setString(index++, this.idade);
            }
            if (this.email != null) {
                ps.setString(index++, this.email);
            }
            if (this.senha != null) {
                ps.setString(index++, this.senha);
            }
            ps.setInt(index, this.pkuser);

            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao Alterar usuario ! <br> " + ex.getMessage();
        }
        return false;
    }

    public void deletar() {
        try {
            sql = "delete from usuarios where ucase(trim(pkuser)) = ucase(trim(?))";
            ps = con.prepareStatement(sql);
            ps.setInt(1, this.pkuser);
            ps.executeUpdate();
            this.statusSQL = null;
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao Alterar usuario ! <br> "
                    + ex.getMessage();
        }
    }
}
