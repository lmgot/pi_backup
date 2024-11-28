<%@page import="java.io.InputStream"%>
<%@page import="JavaBeans.Publicacao"%>
<% 
    Publicacao pub = new Publicacao();
    String legenda = request.getParameter("legenda");
    pub.legenda = legenda;
    
    // Verificando se o arquivo foi enviado
    Part part = request.getPart("postagem");
    if (part != null && part.getSize() > 0) {
        // Se o arquivo foi enviado
        InputStream arquivo = part.getInputStream();
        pub.tamanho = part.getSize();
        pub.foto = arquivo;
    } else {
        pub.foto = null;
        pub.tamanho = 0; // caso não tenha foto
    }
    
    // Agora tentamos adicionar a publicação ao banco
    pub.adicionarPublicacao();
    response.sendRedirect(request.getContextPath() + "perfil.jsp");
%>
