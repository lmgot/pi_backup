package JavaBeans;

import java.io.InputStream;
import java.sql.SQLException;

public class Usuario extends Conexao {

    public int pkuser;
    public String nome;
    public String idade;
    public String email;
    public String senha;
    public InputStream fotoperfil; 
    public long tamanhoperfil;
    public String imagemBase64perfil;

    public boolean checarLogin() {
        try {
            sql = "select * from usuarios where email = ? and senha = ?";
            ps = con.prepareStatement(sql); // prepara SQL
            ps.setString(1, email); // Configura Parametros
            ps.setString(2, senha); // Configura Parametros
            tab = ps.executeQuery(); // Executa comando SQL
            if (tab.next()) {
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
            sql = "insert into usuarios (nome, idade, email, senha, foto) " + "values (?,?,?,?,?) ";
            ps = con.prepareStatement(sql);
            ps.setString(1, nome);
            ps.setString(2, idade);
            ps.setString(3, email);
            ps.setString(4, senha);
            ps.setBlob(5, fotoperfil, tamanhoperfil);
            ps.executeUpdate();
            this.statusSQL = null;
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao incluir usuario! Tente novamente mais tarde! <br> " + ex.getMessage();
        }
    }

    public void alterar() {
        try {
            sql = "update usuarios set nome=?, email=?, senha=?, foto=?, where email=? ";
            ps = con.prepareStatement(sql);
            ps.setString(1, nome);
            ps.setString(2, idade);
            ps.setString(3, email);
            ps.setString(4, senha);
            ps.executeUpdate();
            this.statusSQL = null;
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao Alterar usuario ! <br> " + ex.getMessage();
        }
    }

    public void deletar() {
        try {
            sql = "delete from usuarios where ucase(trim(email)) = ucase(trim( ?))";
            ps = con.prepareStatement(sql); 
            ps.setString(1, email);
            ps.executeUpdate(); 
            this.statusSQL = null;
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao Alterar usuario ! <br> "
                    + ex.getMessage();
        }
    }
}
