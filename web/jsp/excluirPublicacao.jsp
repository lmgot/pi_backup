<%@ page import="JavaBeans.Publicacao" %>
<%
    Integer pkpublicacao = Integer.parseInt(request.getParameter("pkpublicacao"));

    if (pkpublicacao != null) {
        Publicacao pub = new Publicacao();
        pub.pkpublicacao = pkpublicacao;

        pub.exluirPublicacao();

        if (pub.statusSQL == null) {
            out.println("<script>alert('Publicação excluída com sucesso!');</script>");
        } else {
            out.println("<script>alert('Erro ao excluir publicação: " + pub.statusSQL + "');</script>");
        }
        response.sendRedirect("perfil.jsp");
    } else {
        out.println("<script>alert('Erro: Publicação não encontrada.');</script>");
        response.sendRedirect("perfil.jsp");
    }
%>
