<%@ page import="JavaBeans.Usuario, javax.servlet.http.HttpSession" %>
<%
    // Recuperar a sess�o para obter o usu�rio logado
    session = request.getSession(false);
    if (session == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Recuperar dados do formul�rio
    String novoNome = request.getParameter("nome");
    String novaIdade = request.getParameter("idade");
    String novoEmail = request.getParameter("email");
    String novaSenha = request.getParameter("senha");

    // Validar dados (opcional, para evitar campos nulos ou inv�lidos)
    if ((novoNome == null || novoNome.trim().isEmpty())
            && (novaIdade == null || novaIdade.trim().isEmpty())
            && (novoEmail == null || novoEmail.trim().isEmpty())
            && (novaSenha == null || novaSenha.trim().isEmpty())) {
        out.println("<script>alert('Nenhum dado foi fornecido para altera��o.'); window.location.href='configuracoes.html';</script>");
        return;
    }

    // Obter o ID do usu�rio da sess�o
    Integer pkuser = (Integer) session.getAttribute("pkuser");
    if (pkuser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Instanciar o objeto Usuario
    Usuario usuario = new Usuario();
    usuario.pkuser = pkuser; // Definir o identificador do usu�rio

    // Atualizar os campos somente se fornecidos
    if (novoNome != null && !novoNome.trim().isEmpty()) {
        usuario.nome = novoNome;
    }
    if (novaIdade != null && !novaIdade.trim().isEmpty()) {
        usuario.idade = novaIdade; // Supondo que idade � um n�mero inteiro
    }
    if (novoEmail != null && !novoEmail.trim().isEmpty()) {
        usuario.email = novoEmail;
    }
    if (novaSenha != null && !novaSenha.trim().isEmpty()) {
        usuario.senha = novaSenha;
    }

    // Chamar o m�todo de atualiza��o
    boolean atualizado = usuario.atualizarDados();

    session.setAttribute("nome", usuario.nome);
    session.setAttribute("email", usuario.email);
    session.setAttribute("pkuser", usuario.pkuser);

    // Redirecionar ou exibir mensagem baseada no resultado
    if (atualizado) {
        out.println("<script>alert('Dados atualizados com sucesso!'); window.location.href='perfil.jsp';</script>");
    } else {
        out.println("<script>alert('Erro ao atualizar dados. Tente novamente.'); window.location.href='configuracoes.html';</script>");
    }
%>
