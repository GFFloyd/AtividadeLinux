# Atividade Linux
*Estágio DevSecOps | Compass.UOL*

---

### 1º Passo - Instalação do WSL

Para a instalação do WSL no Windows, precisamos habilitar a virtualização na UEFI.

Depois que esta etapa for concluída, iremos abrir o PowerShell e usar o comando:

```powershell
wsl --install
```

Depois de instalado, o Windows deverá ser reiniciado e depois temos que dizer ao WSL qual a distro de nossa preferência, como a atividade pede para usarmos o Ubuntu, o comando deve ser assim:

```powershell
wsl --install -d Ubuntu
```

Ele irá baixar o Ubuntu em sua versão LTS do WSL (24.04.1).



