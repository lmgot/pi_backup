package JavaBeans;

import com.mysql.cj.jdbc.Blob;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class Publicacao extends Usuario {

    public int pkpublicacao;
    public InputStream foto;
    public long tamanho;
    public String imagemBase64;
    public String legenda;

    public void adicionarPublicacao() {
    try {
        sql = "INSERT INTO publicacoes (pkuser, foto, legenda) VALUES (?, ?, ?)";
        ps = con.prepareStatement(sql);
        ps.setInt(1, pkuser);  // Certifique-se de que pkuser está definido
        if (foto != null) {
            ps.setBlob(2, foto, tamanho);  // Armazena a foto no banco
        } else {
            ps.setNull(2, java.sql.Types.BLOB);  // Caso não tenha foto
        }
        ps.setString(3, legenda);  // Armazena a legenda
        ps.executeUpdate();
    } catch (SQLException ex) {
        statusSQL = "Erro ao adicionar publicação! " + ex.getMessage();
        ex.printStackTrace();
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

    public List<Publicacao> buscarPublicacoes() {
        List<Publicacao> publicacoes = new ArrayList<>();
        try {
            sql = "SELECT * FROM publicacoes WHERE pkuser = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, pkuser);  // Filtra pelo ID do usuário
            tab = ps.executeQuery();

            while (tab.next()) {
                Publicacao pub = new Publicacao();
                pub.pkpublicacao = tab.getInt("pkpublicacao");
                pub.pkuser = tab.getInt("pkuser");
                pub.legenda = tab.getString("legenda");

                // Converte a foto BLOB para Base64
                Blob fotoBlob = (Blob) tab.getBlob("foto");
                if (fotoBlob != null) {
                    InputStream fotoStream = fotoBlob.getBinaryStream();
                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = fotoStream.read(buffer)) != -1) {
                        baos.write(buffer, 0, bytesRead);
                    }
                    pub.imagemBase64 = Base64.getEncoder().encodeToString(baos.toByteArray());
                }

                publicacoes.add(pub);
            }
            statusSQL = null;
        } catch (SQLException | IOException ex) {
            statusSQL = "Erro ao buscar publicações! " + ex.getMessage();
        }
        return publicacoes;
    }

}
