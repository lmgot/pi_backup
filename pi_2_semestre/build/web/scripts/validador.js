function validar(event) {
    event.preventDefault();
    
    const form = document.forms["formperfil"];
    const email = form["email"];
    const senha = form["senha"];

    if (email.value.trim() === "") {
        alert('Por favor, digite seu email cadastrado');
        email.focus();
        return false;  // Impede o envio do formulário
    } else if (senha.value.trim() === "") {
        alert('Por favor, digite sua senha para prosseguir');
        senha.focus();
        return false;  // Impede o envio do formulário
    } else {
        form.submit();  // Submete o formulário
        return true;
    }
}