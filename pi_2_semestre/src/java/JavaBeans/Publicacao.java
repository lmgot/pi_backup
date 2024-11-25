package JavaBeans;

import com.mysql.cj.jdbc.Blob;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Base64;

public class Publicacao extends Usuario {

    public int pkpublicacao;
    public InputStream foto; 
    public long tamanho;
    public String imagemBase64;
    public String legenda;

    public void adicionarPublicacao() {
        try {
            sql = "insert into publicacoes (imagem, legenda)" + "values (?, ?) ";
            ps = con.prepareStatement(sql);
            ps.setBlob(1, foto, tamanho);
            ps.setString(2, legenda);
            ps.executeUpdate();
            this.statusSQL = null;
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao tentar buscar Usuário! Tente novamente! " + ex.getMessage();
        }
    }

    public void exluirPublicacao() {
        try {
            sql = "delete from publicacoes where pkpublicacao = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, pkpublicacao);
            ps.executeUpdate();
            this.statusSQL = null;
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao tentar buscar Usuário! Tente novamente! " + ex.getMessage();
        }
    }

    public void buscarImagem() throws IOException {
        try {
            sql = "SELECT foto FROM usuarios WHERE pkuser = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, 1);
            tab = ps.executeQuery();

            if (tab.next()) {
                Blob blob = (Blob) tab.getBlob("foto");
                if (blob == null) {
                    imagemBase64 = null;
                } else {
                    foto = blob.getBinaryStream();
                    byte[] buffer = new byte[(int) blob.length()];
                    foto.read(buffer);
                    imagemBase64 = Base64.getEncoder().encodeToString(buffer);
                }
            }
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao tentar buscar Usuário! Tente novamente! " + ex.getMessage();
        }

    }
}
