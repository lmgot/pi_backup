<%@ page import="javax.servlet.http.HttpSession, java.sql.Blob, java.io.InputStream, java.io.ByteArrayOutputStream, java.util.Base64, JavaBeans.Publicacao, java.util.List" %>
<%
    session = request.getSession(false);
    String nome = "";
    String email = "";
    String imagemBase64 = null;
    Integer pkuser = null;

    if (session != null) {
        nome = (String) session.getAttribute("nome");
        email = (String) session.getAttribute("email");
        pkuser = (Integer) session.getAttribute("pkuser");
        Blob fotoBlob = (Blob) session.getAttribute("foto");

        if (fotoBlob != null) {
            try {
                InputStream fotoStream = fotoBlob.getBinaryStream();
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fotoStream.read(buffer)) != -1) {
                    baos.write(buffer, 0, bytesRead);
                }
                imagemBase64 = Base64.getEncoder().encodeToString(baos.toByteArray());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    } else {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    // Buscar as publicações do usuário
    List<Publicacao> publicacoes = null;
    if (pkuser != null) {
        Publicacao pub = new Publicacao();
        pub.pkuser = pkuser;
        publicacoes = pub.buscarPublicacoes();
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Perfil do Usuário</title>
    <link rel="stylesheet" href="../perfilogado.css">
    <style>
        /* Mantenha o estilo existente, apenas ajustando a galeria */
        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            padding: 20px;
        }

        .publicacao {
            border: 1px solid #ccc;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }

        .publicacao img {
            width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .botoes {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1 class="destaque">stand out.</h1>
            <nav>
                <ul>
                    <ol><a href="../descubralogado.html"><strong>Descubra</strong></a></ol>
                    <ol><a href="../crielogado.html"><strong>Crie</strong></a></ol>
                    <ol><a href="jsp/perfil.jsp"><strong>Perfil</strong></a></ol>
                </ul>
            </nav>
        </div>
    </header>

    <main>
        <h2>Bem-vindo, <%= nome %>!</h2>

        <% if (imagemBase64 != null) { %>
            <img src="data:image/jpeg;base64,<%= imagemBase64 %>" alt="Foto de Perfil" style="width: 150px; height: 150px; border-radius: 50%;">
        <% } else { %>
            <p>Você ainda não tem foto de perfil.</p>
        <% } %>

        <button onclick="window.location.href='logout.jsp'">Deslogar</button>
        <a href='../configuracoes.html'>Configurações</a>

        <hr>

        <h2>Suas Publicações</h2>
        <div class="gallery">
        <% 
            if (publicacoes != null && !publicacoes.isEmpty()) {
                for (Publicacao p : publicacoes) {
        %>
            <div class="publicacao">
                <img src="data:image/jpeg;base64,<%= p.imagemBase64 %>" alt="Publicação">
                <p>Legenda: <%= p.legenda %></p>
                <div class="botoes">
                    <!-- Formulário para editar legenda -->
                    <form method="post" action="editarPublicacao.jsp" style="display: inline;">
                        <input type="hidden" name="pkpublicacao" value="<%= p.pkpublicacao %>">
                        <input type="text" name="novaLegenda" placeholder="Nova legenda">
                        <button type="submit">Editar</button>
                    </form>
                    <!-- Formulário para excluir publicação -->
                    <form method="post" action="excluirPublicacao.jsp" style="display: inline;">
                        <input type="hidden" name="pkpublicacao" value="<%= p.pkpublicacao %>">
                        <button type="submit" style="background-color: red; color: white;">Excluir</button>
                    </form>
                </div>
            </div>
        <%
                }
            } else {
        %>
            <p>Você ainda não possui publicações.</p>
        <% } %>
        </div>
    </main>

    <footer>
        <div class="destaque">
            <h2>stand<br>out.</h2>
        </div>
        <nav>
            <ul>
                <p>MARCA</p>
                <ol><p>Sobre</p></ol>
                <ol><p>Missão</p></ol>
                <ol><p>Contato</p></ol>
            </ul>
        </nav>
        <p class="termos">
            Todos os direitos reservados a empresa "stand out."<br>Termos e Condições | Privacidade
        </p>
    </footer>
</body>
</html>
