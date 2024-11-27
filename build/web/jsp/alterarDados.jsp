<%@ page import="JavaBeans.Usuario, javax.servlet.http.HttpSession" %>
<%
    // Recuperar a sessão para obter o usuário logado
    session = request.getSession(false);
    if (session == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Recuperar dados do formulário
    String novoNome = request.getParameter("nome");
    String novaIdade = request.getParameter("idade");
    String novoEmail = request.getParameter("email");
    String novaSenha = request.getParameter("senha");

    // Validar dados (opcional, para evitar campos nulos ou inválidos)
    if ((novoNome == null || novoNome.trim().isEmpty())
            && (novaIdade == null || novaIdade.trim().isEmpty())
            && (novoEmail == null || novoEmail.trim().isEmpty())
            && (novaSenha == null || novaSenha.trim().isEmpty())) {
        out.println("<script>alert('Nenhum dado foi fornecido para alteração.'); window.location.href='configuracoes.html';</script>");
        return;
    }

    // Obter o ID do usuário da sessão
    Integer pkuser = (Integer) session.getAttribute("pkuser");
    if (pkuser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Instanciar o objeto Usuario
    Usuario usuario = new Usuario();
    usuario.pkuser = pkuser; // Definir o identificador do usuário

    // Atualizar os campos somente se fornecidos
    if (novoNome != null && !novoNome.trim().isEmpty()) {
        usuario.nome = novoNome;
    }
    if (novaIdade != null && !novaIdade.trim().isEmpty()) {
        usuario.idade = novaIdade; // Supondo que idade é um número inteiro
    }
    if (novoEmail != null && !novoEmail.trim().isEmpty()) {
        usuario.email = novoEmail;
    }
    if (novaSenha != null && !novaSenha.trim().isEmpty()) {
        usuario.senha = novaSenha;
    }

    // Chamar o método de atualização
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
