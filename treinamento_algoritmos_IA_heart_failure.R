#ESTE CODIGO MOSTRA O TREINAMENTO E COMPARA��O DE 2 ALGORITMOS DE INTELIG�NCIA ARTIFICIAL
# PARA PREVIS�O DE �BITO DURANTE FOLLOW-UP DE PACIENTES. 
# O ATRIBUTO A SER PREVISTO (atributo classe) � O DEATH_EVENT (1 sendo o paciente que veio a �bito)

#PRIMEIRO PASSO � IMPORTAR A BASE DE DADOS (https://www.kaggle.com/andrewmvd/heart-failure-clinical-data)
base_de_dados <- read.csv('heart_failure.csv', header = TRUE)

#AN�LISE R�PIDA DOS ATRIBUTOS
table(is.na(base_de_dados)) #checar se h� valores faltantes, retornou falso
head(base_de_dados) #checar atributos

#ESCALONAMOS os atributos das colunas que n�o cont�m vari�veis booleanas, para usar em algoritmo baseado em dist�ncias posteriormente 
colunas_escalonadas = c(1, 3, 5, 7, 8, 9, 12)
base_de_dados[, colunas_escalonadas] = scale(base_de_dados[, colunas_escalonadas])

#PRECISAMOS TRANSFORMAR O TIPO DA VARI�VEL DO ARGUMENTO DE CLASSE EM FATOR (encode do atributo classe)
base_de_dados$DEATH_EVENT <- factor(base_de_dados$DEATH_EVENT, levels <- c(0,1))

#ENT�O, DIVIDIMOS A BASE DE DADOS EM BASE DE TESTE E DE TREINAMENTO
library(caTools)
set.seed(1234)
divisao <- sample.split(base_de_dados$DEATH_EVENT, SplitRatio = 0.75)
base_treinamento <- subset(base_de_dados, divisao == TRUE)
base_teste <- subset(base_de_dados, divisao == FALSE)

#VERIFICANDO A BASE DE TESTES, RETIRANDO O ATRIBUTO CLASSE (DEATH_EVENT)
head(base_teste[,-13])

#CRIANDO O CLASSIFICADOR VIA �RVORES DE DECIS�O (treinamento do algoritmo)
library(rpart)
#previs�o usando todos os atributos da base de dados
classificador_decision_tree1 <- rpart(formula=DEATH_EVENT ~ ., data <- base_treinamento)
library(rpart.plot)
rpart.plot(classificador_decision_tree1)

#prevendo utilizando apenas alguns atributos. 
#Isso ap�s olhar a primeira �rvore, fica claro que os atributos � esquerda (time, serum_creatinine, ejection_fraction e serum_sodium explicam melhor o atributo sendo previsto)
classificador_decision_tree2 <- rpart(formula=DEATH_EVENT ~ time + serum_creatinine + ejection_fraction + serum_sodium, data <- base_treinamento)
rpart.plot(classificador_decision_tree2)

#REALIZANDO PREVIS�ES COM BASE A BASE DE TESTE
previsoes_decision_tree <- predict(classificador_decision_tree2, newdata = base_teste[-13])
previsoes_decision_tree #ele retorna a probabilidade da entrada ser 0 ou 1

#mas precisamos, para comparar acur�cia e outros usos apenas saber se o resultado � 0 ou 1. 
#para tal, adicionamos o atributo "type=class" na fun��o predict:
previsoes_decision_tree2 <- predict(classificador_decision_tree2, newdata = base_teste[-13], type <- 'class')

#criamos a matriz de confus�o para este algoritmo, para determinar a acur�cia
confusao_tree <- table(base_teste$DEATH_EVENT, previsoes_decision_tree2)

library('caret')
confusionMatrix(confusao_tree) #retorna m�tricas do ajuste


#CRIANDO CLASSIFICADOR POR SUPPORT VECTOR MACHINE (treinamento do algoritmo SVM)
library('e1071')
#parametros type: se o SVM ir� classificar registros ou prever valores num�ricos, como regress�es
#kernel = tipo de aumento de dimens�o para tratar hiperplanos mais adequados � previsão
#cost = custos associados �s viola��es de restri��es na hora de encontrar o melhor hiperplano para previs�o
classificador_svm <- svm(formula = DEATH_EVENT ~., data = base_treinamento, type = 'C-classification', 
                     kernel='sigmoid', cost = 1)

#verificar os detalhes do ajuste, usando kernel sigmoide, C-Classification e custo = 1
classificador_svm
#realizar previs�es usando fun��o predict
previsoes_svm <- predict(classificador_svm, newdata = base_teste[-13])
confusao_svm <- table(previsoes_svm, base_teste[,13])


#avaliando a acur�cia do SVM para a base de dados de teste:
library('caret')
confusionMatrix(confusao_svm)




