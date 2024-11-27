<%@ page import="JavaBeans.Usuario" %>
<%
    // Pega a chave primária do usuário da sessão
    session = request.getSession(false);
    Integer pkuser = (Integer) session.getAttribute("pkuser");

    if (pkuser != null) {
        Usuario usuario = new Usuario();
        usuario.pkuser = pkuser; // Define o pkuser para a classe Usuario

        // Deleta a conta do usuário
        usuario.deletar();

        if (usuario.statusSQL == null) {
            session.invalidate();  // Invalida a sessão após excluir a conta
            response.sendRedirect("../index.html");  // Redireciona para a tela de login
        } else {
            out.println("<script>alert('Erro ao deletar conta: " + usuario.statusSQL + "');</script>");
        }
    } else {
        response.sendRedirect("../index.html");
    }
%>

