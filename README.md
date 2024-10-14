# Atividade Linux
*Estágio DevSecOps | Compass.UOL*

---

### 1º Passo - Instalação do WSL

Para a instalação do WSL no Windows, precisamos habilitar a virtualização na UEFI.

Para ver como habilitar virtualização, clique no link: [Como habilitar virtualização](https://support.microsoft.com/pt-br/windows/habilitar-a-virtualiza%C3%A7%C3%A3o-no-windows-c5578302-6e43-4b4b-a449-8ced115f58e1).

Depois que esta etapa for concluída, iremos abrir o PowerShell e usar o comando:

```powershell
wsl --install
```

Depois de instalado, o Windows deverá ser reiniciado e depois temos que dizer ao WSL qual a distro de nossa preferência, como a atividade pede para usarmos o Ubuntu, o comando deve ser assim:

```powershell
wsl --install -d Ubuntu
```

Ele irá baixar o Ubuntu em sua versão LTS do WSL (24.04.1).

Assim que estivermos no terminal do Ubuntu, com um usuário cadastrado, é uma boa prática dar o seguinte comando para atualizar o sistema:
```bash
sudo apt update && sudo apt upgrade -y
```

---

### 2º Passo - Criação do Repositório e Conexão com o GitHub

Agora que estamos com o sistema atualizado, iremos criar o repositório no git, por padrão, no Ubuntu, o git já vem instalado.
Vamos criar um diretório onde iremos colocar os arquivos pertinentes ao projeto, no meu caso eu chamei de AtividadeLinux, depois vamos entrar no diretório:

```bash
mkdir AtividadeLinux
cd /AtividadeLinux/
```
É boa prática criar um arquivo chamado README.md dentro do repositório, ele serve como a documentação geral do seu projeto, vamos fazer isso e inicializar o repositório:

```bash
touch README.md
git init
```

Agora que temos o arquivo inicial do repositório, iremos dar um commit dessa mudança, mas para isso precisaremos conectar o git do terminal com o GitHub, para conseguir uma conexão com o GitHub iremos precisar criar uma chave SSH com o seguinte comando:

```bash
ssh-keygen -t ed25519 -C "seuemail@exemplo.com"
```

Após este comando, teremos duas chaves SSH, uma pública e outra privada, iremos usar a chave pública para conectar ao GitHub.
Para conectar a chave ao GitHub, iremos em Settings -> SSH and GPG keys -> New SSH key, onde deve ser colado a chave SSH. Se tudo der certo, o GitHub irá avisar que a chave foi adicionada com sucesso.
Se caso não der certo este processo, recomendo dar uma lida no seguinte link: [Gerando chave SSH](https://docs.github.com/pt/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

Para conectar o git ao GitHub, iremos utilizar o seguinte comando:

```bash
ssh -T git@github.com
```

Se tudo der certo, espera-se que o output seja este:

```bash
> Hi USERNAME! You've successfully authenticated, but GitHub does not
> provide shell access.
```

Isso significa que você está conectado ao GitHub pelo Git. Agora podemos modificar nosso repositório pelo terminal.

Vamos fazer isso com a nossa modificação inicial de ter criado o arquivo README.md e dar um commit desta alteração e depois mandar esse commit para o repositório, usando os seguintes comandos:

```bash
git add README.md
git commit -m "criado o README.md"
git push
```

Agora podemos fazer o mesmo processo para o nosso arquivo de script e colocar ele no repositório:

```bash
touch scriptNginx.sh
git add scriptNginx.sh
git commit -m "criado o scriptNginx.sh"
git push
```
Agora tudo está pronto para escrever o script e verificar se o serviço do Nginx está online ou offline.
