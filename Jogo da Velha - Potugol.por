programa {
  inclua biblioteca Tipos --> tp
  inclua biblioteca Util --> ut
  inclua biblioteca Texto --> tx
  inteiro index = 0
  cadeia historico[100]

  funcao inicio() {
    
    
    menu()

  }
  // IMPRIMIR TABULEIRO ------------------------------------------------------------------------------------------------------
  funcao exibeTabuleiro(caracter tabuleiro[][]){
    linha()
    escreva("|                                                        |\n")
    escreva("|                  |  ",tabuleiro[0][0],"  |  ",tabuleiro[0][1], "  |  ",tabuleiro[0][2],"  |                   |\n")
    escreva("|                  |:---------------:|                   |\n")
    escreva("|                  |  ",tabuleiro[1][0],"  |  ",tabuleiro[1][1], "  |  ",tabuleiro[1][2],"  |                   |\n")
    escreva("|                  |:---------------:|                   |\n")
    escreva("|                  |  ",tabuleiro[2][0],"  |  ",tabuleiro[2][1], "  |  ",tabuleiro[2][2],"  |                   |\n")
    escreva("|                                                        |\n")
    linha()
  }
  funcao menu(){
    cadeia entrada, jogador1, jogador2

    enquanto(entrada != 1 e entrada != 2 e entrada != 3){
      separador()
      escreva("|:::::::::::::::::[ JOGO DA VELHA (#) ]::::::::::::::::::|\n")
      separador() escreva("\n")
      escreva("|:---------------------:[ MENU ]:-----------------------:|\n")
      escreva("| [1] JOGAR                                              |\n")
      escreva("| [2] HISTÓRICO                                          |\n")
      escreva("| [3] SAIR                                               |\n")
      linha()
      escreva("| Digite a Opção: -> ") 
      leia(entrada)
      limpa()
      se(entrada != 1 e entrada != 2 e entrada != 3){
        separador()
        escreva("| Opção inválida                                         |", "\n")
      }
    }
    escolha(entrada){
        caso "1": 
          jogador1 = cadastraJogador(1)
          jogador2 = cadastraJogador(2)
          iniciarPartida(jogador1, jogador2)
          limpa()
          menu(index,historico)
        pare
        caso "2": 
          listarHistorico()
          limpa()
          menu()
        pare
        caso "3": 
          sairDoPrograma() 
        pare
      }
  }

  //==========================================================================================================================
  // FUNÇÕES

  funcao separador(){
    escreva("|========================================================|\n") 
  }

  funcao linha(){
    escreva("|:------------------------------------------------------:|\n")
  }

  funcao listarHistorico(){
    cadeia entrada
    limpa()
    escreva("|:-------------------:[ HISTÓRICO ]:--------------------:|\n")
    escreva("|                                                        |\n")
    para(inteiro i = 0; i < index; i++){
      escreva("| Partida [",i+1,"]",": Vencerdor [",historico[i],"]\n")
      linha()
    }
    escreva("| para voltar ao Menu, pressione ENTER:                  |", "\n")
    separador()
    leia(entrada)
  }

  funcao cadeia cadastraJogador(inteiro numeroDoJogador){
    cadeia jogador, entrada
    vazio jogadorEstaVazio
    inteiro tamanhoNome
    enquanto(jogador == jogadorEstaVazio){
      separador()
      escreva(
        "| Qual o nome do Jogador Nº", numeroDoJogador," ?                           |","\n",
        "| Jogador Nº",numeroDoJogador ,": "
      )
      leia(entrada)
      se(entrada >= "a" e entrada <= "z" ou entrada >= "A" e entrada <= "Z"){
        tamanhoNome = tx.numero_caracteres(entrada)
        se(tamanhoNome < 15){
          linha()
          escreva(
          "| Salvo! O Jogador[", numeroDoJogador ,"] será o ", entrada, "\n"
          )
          linha()
          ut.aguarde(2000)
          jogador = entrada
        } senao {
          limpa()
          separador()
          escreva(
            "|                        [ ERRO ]                        |", "\n",
            "|         O nome deve ter menos de 15 caracteres!        |", "\n",
            "|         Vamos tentar novamente                         |", "\n"
          )
        }
      } senao {
        limpa()
        separador()
        escreva(
          "|                        [ ERRO ]                        |", "\n",
          "|         Não consegui entender o que você digitou       |", "\n",
          "|         Tente um nome diferente                        |", "\n"
        )
      }
    }
    limpa()
    retorne jogador
  }
  
  funcao iniciarPartida(cadeia jogador1, cadeia jogador2){
    caracter tabuleiro[3][3] = {{'1','2','3'},{'4','5','6'},{'7','8','9'}}
    inteiro idJogador = 1
    exibeTabuleiro(tabuleiro)
    enquanto(partidaTerminou(tabuleiro) == falso){
      se(idJogador == 1){
        realizarJogada(idJogador, tabuleiro)
        limpa()
        exibeTabuleiro(tabuleiro)
        idJogador = 2
      } senao se(idJogador == 2) {
        realizarJogada(idJogador,  tabuleiro)
        limpa()
        exibeTabuleiro(tabuleiro)
        idJogador = 1
      }
    }
    verificaQuemGanhou(tabuleiro, jogador1, jogador2)
    cadeia entrada
    escreva("| Pressione ENTER para voltar ao Menu                    |", "\n")
    separador()
    leia(entrada)
  }

  funcao logico verificaSePosicaoEstaDisponivel(caracter posicaoEscolhida, caracter tabuleiro[][]){
    para(inteiro linha = 0; linha < 3; linha++){
      para(inteiro coluna = 0; coluna < 3; coluna++){
        se(tabuleiro[linha][coluna] == posicaoEscolhida){
          retorne verdadeiro
        }
      }
    }
    retorne falso
  }

  funcao registraJogadaNoTabuleiro(caracter posicaoEscolhida, caracter tabuleiro[][], caracter marcador){
    para(inteiro linha = 0; linha < 3; linha++){
      para(inteiro coluna = 0; coluna < 3; coluna++){
        se(tabuleiro[linha][coluna] == posicaoEscolhida){
          tabuleiro[linha][coluna] = tp.cadeia_para_caracter(marcador)
          pare
        }
      }
    }
  }

  funcao realizarJogada(inteiro idJogador, caracter tabuleiro[][]){
    logico concluiuJogada = falso
    caracter marcador, posicaoEscolhida
    cadeia entrada
    se(idJogador == 1){
      marcador = 'X'
    } senao se(idJogador == 2){
      marcador = 'O'
    }
    enquanto(concluiuJogada == falso){
      escreva(
        "| ","Jogador [", idJogador, "] é a sua vez!","                               |", "\n",
        "| ","Escolha um dos números disponíveis","                     |", "\n",
        "| ","Digite o número desejado e pressione ENTER: ", "           |","\n"
      )
      linha()
      escreva("| Digite a Opção: -> ") 
      leia(entrada)
      se(entrada > 0 e entrada < 10){
        posicaoEscolhida = tp.cadeia_para_caracter(entrada)
        se(verificaSePosicaoEstaDisponivel(posicaoEscolhida, tabuleiro)){
          registraJogadaNoTabuleiro(posicaoEscolhida, tabuleiro, marcador)
          concluiuJogada = verdadeiro
        } senao {
          limpa()
          separador()
          escreva(
          "|                        [ ERRO ]                        |", "\n",
          "|                 Muita calma nessa hora                 |", "\n",
          "|         A posição escolhida já esta ocupada!           |", "\n",
          "|                 Tente outra posição...                 |", "\n"
          )
          exibeTabuleiro(tabuleiro)
        }
      } senao {
        limpa()
        separador()
        escreva(
          "|                        [ ERRO ]                        |", "\n",
          "|                    Péssima escolha!                    |", "\n",
          "|        O valor digitado não é uma entrada válida!      |", "\n",
          "|                    Tente novamente...                  |", "\n"
        )
        exibeTabuleiro(tabuleiro)
      }
    }
  }
  
  funcao logico partidaTerminou(caracter tabuleiro[][]){
    inteiro contadorDeJogadas = 0
    //Linhas
    se((tabuleiro[0][0] == tabuleiro[0][1]) e (tabuleiro[0][1] == tabuleiro[0][2])){
      retorne verdadeiro
    } senao se((tabuleiro[1][0] == tabuleiro[1][1]) e (tabuleiro[1][1] == tabuleiro[1][2])){
      retorne verdadeiro
    } senao se((tabuleiro[2][0] == tabuleiro[2][1]) e (tabuleiro[2][1] == tabuleiro[2][2])){
      retorne verdadeiro
    }
    //Colunas
    se((tabuleiro[0][0] == tabuleiro[1][0]) e (tabuleiro[1][0] == tabuleiro[2][0])){
      retorne verdadeiro
    } senao se((tabuleiro[0][1] == tabuleiro[1][1]) e (tabuleiro[1][1] == tabuleiro[2][1])){
      retorne verdadeiro
    } senao se((tabuleiro[0][2] == tabuleiro[1][2]) e (tabuleiro[1][2] == tabuleiro[2][2])){
      retorne verdadeiro
    }
    //Diagonal
    se((tabuleiro[0][0] == tabuleiro[1][1]) e (tabuleiro[1][1] == tabuleiro[2][2])){
      retorne verdadeiro
    } senao se((tabuleiro[0][2] == tabuleiro[1][1]) e (tabuleiro[1][1] == tabuleiro[2][0])){
      retorne verdadeiro
    }
    //Empate
    para(inteiro linha = 0; linha < 3; linha++){
      para(inteiro coluna = 0; coluna < 3; coluna++){
        se(tabuleiro[linha][coluna] == 'X' ou tabuleiro[linha][coluna] == 'O'){
          contadorDeJogadas++
        }
      }
    }

    enquanto(contadorDeJogadas < 9){
      retorne falso
    }
    retorne verdadeiro
  }

  funcao verificaQuemGanhou(caracter tabuleiro[][], cadeia jogador1, cadeia jogador2){
    inteiro contadorDeJogadas = 0
    logico empatou = verdadeiro
    //Linhas
    se((tabuleiro[0][0] == tabuleiro[0][1]) e (tabuleiro[0][1] == tabuleiro[0][2])){
      se(tabuleiro[0][0] == 'X'){
        empatou = mensagemVencedor('X', jogador1, jogador2)
      } senao se(tabuleiro[0][0] == 'O'){
        empatou = mensagemVencedor('O', jogador1, jogador2)
      }
    } senao se((tabuleiro[1][0] == tabuleiro[1][1]) e (tabuleiro[1][1] == tabuleiro[1][2])){
      se(tabuleiro[1][0] == 'X'){
        empatou = mensagemVencedor('X', jogador1, jogador2)
      } senao se(tabuleiro[1][0] == 'O'){
        empatou = mensagemVencedor('O', jogador1, jogador2)
      }
    } senao se((tabuleiro[2][0] == tabuleiro[2][1]) e (tabuleiro[2][1] == tabuleiro[2][2])){
      se(tabuleiro[2][0] == 'X'){
        empatou = mensagemVencedor('X', jogador1, jogador2)
      } senao se(tabuleiro[2][0] == 'O'){
        empatou = mensagemVencedor('O', jogador1, jogador2)
      }
    }
    //Colunas
    se((tabuleiro[0][0] == tabuleiro[1][0]) e (tabuleiro[1][0] == tabuleiro[2][0])){
      se(tabuleiro[0][0] == 'X'){
        empatou = mensagemVencedor('X', jogador1, jogador2)
      } senao se(tabuleiro[0][0] == 'O'){
        empatou = mensagemVencedor('O', jogador1, jogador2)
      }
    } senao se((tabuleiro[0][1] == tabuleiro[1][1]) e (tabuleiro[1][1] == tabuleiro[2][1])){
      se(tabuleiro[0][1] == 'X'){
        empatou = mensagemVencedor('X', jogador1, jogador2)
      } senao se(tabuleiro[0][1] == 'O'){
        empatou = mensagemVencedor('O', jogador1, jogador2)
      }
    } senao se((tabuleiro[0][2] == tabuleiro[1][2]) e (tabuleiro[1][2] == tabuleiro[2][2])){
      se(tabuleiro[0][2] == 'X'){
        empatou = mensagemVencedor('X', jogador1, jogador2)
      } senao se(tabuleiro[0][2] == 'O'){
        empatou = mensagemVencedor('O', jogador1, jogador2)
      }
    }
    //Diagonal
    se((tabuleiro[0][0] == tabuleiro[1][1]) e (tabuleiro[1][1] == tabuleiro[2][2])){
      se(tabuleiro[0][0] == 'X'){
        empatou = mensagemVencedor('X', jogador1, jogador2)
      } senao se(tabuleiro[0][0] == 'O'){
        empatou = mensagemVencedor('O', jogador1, jogador2)
      }
    } senao se((tabuleiro[0][2] == tabuleiro[1][1]) e (tabuleiro[1][1] == tabuleiro[2][0])){
      se(tabuleiro[0][2] == 'X'){
        empatou = mensagemVencedor('X', jogador1, jogador2)
      } senao se(tabuleiro[0][2] == 'O'){
        empatou = mensagemVencedor('O', jogador1, jogador2)
      }
    }
    para(inteiro linha = 0; linha < 3; linha++){
      para(inteiro coluna = 0; coluna < 3; coluna++){
        se(tabuleiro[linha][coluna] == 'X' ou tabuleiro[linha][coluna] == 'O'){
          contadorDeJogadas++
        }
      }
    }
    se(contadorDeJogadas == 9 e empatou){
      escreva(
        "|                       DEU VELHA!                       |","\n",
        "|        Não acho que quem ganhar ou quem perder,        |", "\n",
        "|               nem quem ganhar nem perder,              |", "\n",
        "|                 vai ganhar ou perder.                  |", "\n",
        "|                 Vai todo mundo perder.                 |","\n",
        "|                  - Rousseff, Dilma                     |","\n"
      )
      separador()
    }
  }

  funcao logico mensagemVencedor(caracter simboloVencedor, cadeia jogador1, cadeia jogador2){
    cadeia nomeVencedor, nomePerdedor
    se(simboloVencedor == 'X'){
      nomeVencedor = jogador1
      nomePerdedor = jogador2
    } senao se(simboloVencedor == 'O') {
      nomeVencedor = jogador2
      nomePerdedor = jogador1
    }

    salvaVencedorNoHistorico(nomeVencedor)

    escreva(
      "|                  MANDOU BEM ", nomeVencedor, "!!!!                     ","\n",
      "|            O VENCEDOR desse duelo foi [", simboloVencedor, "]              |","\n",
      "|         ", nomePerdedor, " você foi COMPLETAMENTE ATROPELADO!!        ","\n",
      "|                  Mais sorte na próxima!                | ","\n"
    )
    separador()
    retorne falso
  }

  funcao salvaVencedorNoHistorico(cadeia nomeVencedor){
    index++
    historico[index-1] = nomeVencedor
  }

  funcao sairDoPrograma(){
    separador()
    escreva ("|                  VOCÊ SAIU DO PROGRAMA.                |")
    separador()
  }
}
