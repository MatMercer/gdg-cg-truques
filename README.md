# GDG Londrina 2025 - Truques em Computer Graphics

## Descrição

Este projeto contém uma apresentação sobre truques em Computer Graphics, incluindo uma animação de um donut em ASCII art e uma apresentação web com shaders do Shadertoy.

## Dependências

### Obrigatórias
- **Docker Compose**: Necessário para executar o cache proxy dos shaders

### Opcionais
- **GCC**: Compilador C para executar a animação do donut (se não estiver presente, a animação será pulada)

## Como Executar

### 1. Instalação do Docker Compose

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install docker-compose
```

#### macOS
```bash
# Com Homebrew
brew install docker-compose

# Ou instale o Docker Desktop que já inclui o Docker Compose
```

### 2. Executar o Projeto

Execute o script principal:

```bash
./start-presentation.sh
```

### O que o script faz:

1. **Inicia o cache proxy** com Docker Compose para servir os shaders do Shadertoy
2. **Compila e executa a animação do donut** (se o GCC estiver disponível)
   - A animação roda em ASCII art no terminal
   - Pressione Enter para pará-la e continuar
3. **Abre a apresentação** no navegador padrão

## Estrutura do Projeto

- `start-presentation.sh` - Script principal para executar o projeto
- `donut.c` - Código C da animação do donut (por a1k0n.net)
- `docker-compose.yml` - Configuração do cache proxy
- `presentation/` - Arquivos da apresentação web
- `cached_shaders/` - Shaders do Shadertoy em cache
- `cache/` - Cache do proxy nginx

## Notas

- A apresentação será aberta automaticamente no navegador após a animação
- O cache proxy roda na porta 8888
- Se o GCC não estiver instalado, apenas a apresentação será aberta
- Use Ctrl+C para interromper a execução a qualquer momento

## Créditos

- Animação do donut: [a1k0n.net](https://www.a1k0n.net/2021/01/13/optimizing-donut.html)
- Shaders: [Shadertoy](https://www.shadertoy.com/)