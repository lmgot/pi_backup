<%@ page import="JavaBeans.Publicacao" %>
<%
    Integer pkpublicacao = Integer.parseInt(request.getParameter("pkpublicacao"));

    if (pkpublicacao != null) {
        Publicacao pub = new Publicacao();
        pub.pkpublicacao = pkpublicacao;

        pub.exluirPublicacao();

        if (pub.statusSQL == null) {
            out.println("<script>alert('Publica��o exclu�da com sucesso!');</script>");
        } else {
            out.println("<script>alert('Erro ao excluir publica��o: " + pub.statusSQL + "');</script>");
        }
        response.sendRedirect("perfil.jsp");
    } else {
        out.println("<script>alert('Erro: Publica��o n�o encontrada.');</script>");
        response.sendRedirect("perfil.jsp");
    }
%>
