<%@ page import="javax.servlet.http.HttpSession, java.sql.Blob, java.io.InputStream, java.io.ByteArrayOutputStream, java.util.Base64" %>

<%
    session = request.getSession(false);
    String nome = "";
    String email = "";
    String imagemBase64 = null;

    if (session != null) {
        nome = (String) session.getAttribute("nome");
        email = (String) session.getAttribute("email");
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
        response.sendRedirect(request.getContextPath() + "login.jsp");
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <title>Perfil do Usuário</title>
        <link rel="stylesheet" href="../estilo.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    </head>
    <body>
        <header>
            <div class="container">
                <h1 class="destaque">stand out.</h1>
                <nav>
                    <ul>
                        <ol><a href="index.html"><strong>Home</strong></a></ol>
                        <ol><a href="descubra.html"><strong>Descubra</strong></a></ol>
                        <ol><a href="crie.html"><strong>Crie</strong></a></ol>
                        <ol><a href="conexoes.html"><strong>Conexões</strong></a></ol>
                        <ol><a href="perfil.jsp"><strong>Perfil</strong></a></ol>
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

            <button onclick="window.location.href='logout.jsp';">Logout</button>
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
