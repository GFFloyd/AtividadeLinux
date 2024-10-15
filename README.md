# Atividade Linux
*Estágio DevSecOps | Compass.UOL*

---
### Introdução

A atividade pede que criemos um script em bash que valide se o serviço Nginx está online ou offline a cada 5 minutos, e o script tem que mandar um log para dois arquivos separados, um se o Nginx estiver online e outro se o mesmo estiver offline.
Documentei abaixo todos os passos necessários para criar o script em uma máquina Windows usando o WSL (Windows Subsystem for Linux).

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

---

### 3º Passo - Instalar o Nginx e programar o script

Para instalar o Nginx precisamos dar o seguinte comando:

```bash
sudo apt install nginx
```

Se tudo der certo, o serviço já estará ativo e podemos verificar se o Nginx está funcionando indo no browser e digitando a URL `localhost`, que nos dará uma página de boas vindas ao Nginx.

A etapa de programar o script pode ser verificada no arquivo `.sh` deste repositório, onde documentei cada passo do script.

---

### 4º Passo - Programar o itinerário

Agora que temos o script funcionando do jeito esperado, teremos que programar o itinerário para fazê-lo rodar a cada 5 minutos. Para fazermos isso precisamos de uma função dos sistemas UNIX chamada `cron`, para programar um itinerário do cron, teremos que criar uma `crontab` usando o seguinte comando:

```bash
crontab -e
```

Este comando perguntará qual o editor de texto que vamos trabalhar, depois de selecionado o editor, nos depararemos com um arquivo de texto que diz como programar um itinerário do cron, no final deste arquivo iremos colocar o seguinte texto:

```
*/5 * * * * nome/do/diretório/script.sh 2>&1 | logger -t mycmd
```

Explicando o que o código acima faz:
* A parte dos asteriscos representam caracteres coringa, o primeiro asterisco (*/5) significa que o `cron` será ativado a cada minuto divisível por 5
* Os outros 4 asteriscos representam horas, dia do mês, mês e dia da semana respectivamente, por exemplo, se quiséssemos usar o `cron` para fazer um backup toda semana, às 5h da manhã, usaríamos o seguinte comando: `0 5 * * 1 tar -zcf /var/backups/home.tgz /home/`
* A parte do `2>&1` significa que iremos redirecionar a saída do `stderr` para o `stdout`
* Depois com a saída do `stdout` iremos usar o comando logger para enviá-lo aos logs do sistema, usando o `-t` para criar uma tag única neste log, que será bastante útil para procurar por este nome usando o `grep`

Agora que temos um `crontab` instalado, teremos que iniciar o serviço do `cron` para ele começar a chamar o nosso script a cada 5 minutos, utilizaremos o seguinte comando:

```
sudo service cron start
```

Agora temos um itinerário rodando no sistema, que sempre irá verificar se o serviço do Nginx está online ou offline e criar o log disso a cada 5 minutos, como a atividade pede.

---

## Conclusões finais

Chegamos ao final da atividade proposta. Achei a atividade bastante útil em reforçar alguns aprendizados que obtive ao longo da trilha de Linux, foi a primeira vez que fiz um script em shell e gostei bastante do resultado, a sintaxe difere um pouco das linguagens de programação que eu já estudei e trabalhei, mas dá pra se familiarizar com a mesma rapidamente, já que a estrutura imperativa da linguagem é similar a muitas outras.
Imagino que usaremos bastante scripts do bash ao longo do estágio, para automatizarmos alguns serviços e funções do sistema operacional e de alguns programas. Também acho que usaremos muito o `cron` para programar itinerários específicos.
Também gostei de como eu me sinto mais confortável com o terminal e comandos do bash, antes eu tinha uma pouca familiaridade com os mesmos, mas agora eu acho tudo muito natural.
