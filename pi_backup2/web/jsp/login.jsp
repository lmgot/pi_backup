<%@ page import="JavaBeans.Usuario" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    session = request.getSession(); // Inicia ou recupera a sess�o existente
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    Usuario user = new Usuario();

    // Passa os par�metros para o objeto Usuario
    user.email = email;
    user.senha = senha;

    // Checa o login
    if (user.checarLogin()) {
        session.setAttribute("nome", user.nome);
        session.setAttribute("email", user.email);
        session.setAttribute("pkuser", user.pkuser);  // Armazena a chave prim�ria do usu�rio na sess�os

        // Redireciona para a p�gina do usu�rio ap�s login
        response.sendRedirect(request.getContextPath() + "/indexlogado.html");
    } else {
        // Se falhar, exibe mensagem de erro
        out.println("<script>alert('Email ou senha incorretos!')</script>");
        response.sendRedirect(request.getContextPath() + "/login.html");
    }
%>
