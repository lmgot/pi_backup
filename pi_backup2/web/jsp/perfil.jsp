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
        <title>stand out.</title>
        <link rel="stylesheet" href="../perfilogado.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"> <!-- link para importar a fonte -->
        <link rel="stylesheet" href="/fontes/TAN-NIMBUS.otf">
    </head>
    <body>
        <div class="containervertical">
            <h1 class="destaqueCOMHOVER"><a href="../indexlogado.html" style="text-decoration: none; color: #000000; font-size: xxx-large;">stand out.</a></h1>
            <nav>
                <ul class="menu-vertical">
                    <ol><a href="perfil.jsp"><strong>Perfil</strong></a></ol>
                    <ol><a href="../descubralogado.html"><strong>Descubra</strong></a></ol>
                    <ol><a href="../crielogado.html"><strong>Crie</strong></a></ol>
                    <ol><a href="../sobrelogado.html"><strong>Sobre</strong></a></ol>
                </ul>
            </nav>
        </div>

        <main>
            <h2>Bem-vindo, <%= nome%>!</h2>
            <div class="main">
                <div class="perfil">
                <figure><img src="../PI FOTOS/perifl ilustrativo.jpg" alt="Imagem de Perfil" class="perfil-img"></figure>
                <!--<% if (imagemBase64 != null) {%>
                <div class="perfil">
                    <figure><img src="data:image/jpeg;base64,<%= imagemBase64%>" alt="Imagem de Perfil" class="perfil-img"></figure>
                        <% } else { %>
                    <p style="color:white;">Você ainda não tem foto de perfil.</p>
                    <% }%>-->
                    <div class="info-usuario">
                        <p><strong><%= nome%></strong></p>
                        <p>DESCRIÇÃO</p>
                        <button class="button2" onclick="window.location.href='../configuracoes.html'">Configurações</button>
                        <button class="button2" onclick="window.location.href = 'logout.jsp'">Deslogar</button>

                    </div>
                </div>

                <hr>

                <h2>Suas Publicações</h2>
                <!-- <div class="gallery">
                <%
                    if (publicacoes != null && !publicacoes.isEmpty()) {
                        for (Publicacao p : publicacoes) {
                %>
                <div class="publicacao">
                    <img src="data:image/jpeg;base64,<%= p.imagemBase64%>" alt="Publicação">
                    <p>Legenda: <%= p.legenda%></p>
                    <div class="botoes">
                        <form method="post" action="editarPublicacao.jsp" style="display: inline;">
                            <input type="hidden" name="pkpublicacao" value="<%= p.pkpublicacao%>">
                            <input type="text" name="novaLegenda" placeholder="Nova legenda">
                            <button type="submit">Editar</button>
                        </form>
                        <form method="post" action="excluirPublicacao.jsp" style="display: inline;">
                            <input type="hidden" name="pkpublicacao" value="<%= p.pkpublicacao%>">
                            <button type="submit" style="background-color: red; color: white;">Excluir</button>
                        </form>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <p>Você ainda não possui publicações.</p>
                <% }%>
            </div>-->

                <div class="gallery">
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (1).jpg" alt="Foto 1"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (2).jpg" alt="Foto 2"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (3).jpg" alt="Foto 3"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (4).jpg" alt="Foto 4"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (5).jpg" alt="Foto 5"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (6).jpg" alt="Foto 6"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (7).jpg" alt="Foto 7"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (8).jpg" alt="Foto 8"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (9).jpg" alt="Foto  9"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (10).jpg" alt="Foto 10"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (11).jpg" alt="Foto 11"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (12).jpg" alt="Foto 12"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (13).jpg" alt="Foto 13"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (14).jpg" alt="Foto 14"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (15).jpg" alt="Foto 15"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (16).jpg" alt="Foto 16"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (17).jpg" alt="Foto 17"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (18).jpg" alt="Foto 18"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (19).jpg" alt="Foto 19"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (20).jpg" alt="Foto 20"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (21).jpg" alt="Foto 21"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (22).jpg" alt="Foto 22"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (23).jpg" alt="Foto 23"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (24).jpg" alt="Foto 24"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (25).jpg" alt="Foto 25"></div>
                    <div class="photo"><img src="../PI FOTOS/ref_ilustrativa (26).jpg" alt="Foto 26"></div>
                </div>

                <div id="overlay" class="overlay">
                    <img id="overlay-image" src="" alt="Imagem ampliada">
                </div>
            </div>

            <button id="scrollToTopBtn" onclick="scrollToTop()">Voltar ao Topo</button>

        </main>


        <script>
            const photos = document.querySelectorAll('.photo img');
            const overlay = document.getElementById('overlay');
            const overlayImage = document.getElementById('overlay-image');

            photos.forEach(photo => {
                photo.addEventListener('click', () => {
                    overlayImage.src = photo.src;
                    overlay.style.display = 'flex';
                });
            });

            overlay.addEventListener('click', () => {
                overlay.style.display = 'none';
            });

            let mybutton = document.getElementById("scrollToTopBtn");
            window.onscroll = function () {
                if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
                    mybutton.style.display = "block";
                } else {
                    mybutton.style.display = "none";
                }
            };
            function scrollToTop() {
                window.scrollTo({
                    top: 0,
                    behavior: "smooth"
                });
            }
        </script>
    </body>
</html>
