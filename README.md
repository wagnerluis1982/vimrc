# Meu vimrc

Para instalar, copie os dados para o diretório $HOME/.vim e faça um link
simbólico de $HOME/.vim/vimrc para $HOME/.vimrc

Um outro passo é instalar os submódulos. Eles estão listados em .gitmodules e se
estiver usando o `git`, basta executar dentro do diretório .vim

    $ git submodule init
    $ git submodule update

que todos os submódulos serão baixados


## Principais recursos

* PyMode
* NerdTree

### Atalhos conhecidos (funcionam mesmo no modo de inserção)

    Atalho            |               Descrição
--------------------- | ----------------------------------------------------
`Ctrl-T`              | abre uma nova aba
`Ctrl-Up`/`Ctrl-Down` | rola tela para cima/baixo como uma IDE
`Ctrl-\`              | limpa o destaque de pesquisa (*highlight matches*)
`Ctrl-S`              | salva arquivo no buffer atual
`Alt-[`/`Alt-]`       | anterior/próximo erro de ortografia
`Alt-=`               | correção ortográfica
`Alt-.`               | ignorar erro ortográfico na palavra
`Alt-,`               | desfaz a ação de ignorar erro ortográfico na palavra
