# treinamento-algoritmos-IA
Repositório para mostrar o treinamento e comparação de 2 algoritmos de Inteligência Artificial (IA). O objetivo é prever o óbito de pacientes com problemas cardíacos durante follow-up, baseado em um banco de dados gratuito. O repositório possui 2 arquivos base, os demais são imagens para mostrar resultados ao rodar o código.
 - Arquivo .R com código para importar, tratar e usar dados da base de dados de problemas cardíacos para treinar 2 algoritmos de IA para classificação;
 - Arquivo .CSV com base de dados originais.

Os algoritmos tentam prever, de acordo com atributos dos pacientes, se ele virá a óbito (DEATH_EVENT=1) ou não (DEATH_EVENT=0).

Atributos originais da base de dados:

![alt text](https://github.com/gui-murray/treinamento-algoritmos-IA/blob/main/img1_original_attributes.png?raw=true)

Após escalonamento:

![alt text](https://github.com/gui-murray/treinamento-algoritmos-IA/blob/main/img2_scaled_attributes.png?raw=true)

Árvore de decisão com todos os atributos:

![alt text](https://github.com/gui-murray/treinamento-algoritmos-IA/blob/main/img3_decision_tree_all.png?raw=true)

Árvore de decisão com atributos selecionados:

![alt text](https://github.com/gui-murray/treinamento-algoritmos-IA/blob/main/img4_decision_tree_selected.png?raw=true)
 
Previsões do algoritmo Árvores de Decisão (retorna a probabilidade do paciente ter morrido (1) ou não (0), para cada paciente da base de dados de teste:

![alt text](https://github.com/gui-murray/treinamento-algoritmos-IA/blob/main/img5_predict_decisiontree.png?raw=true)
 
Qualidade do ajuste. Acurácia de 80%, previu 6 óbitos que não ocorreram. Previu que 9 pacientes que sobreviveram morreriam:

![alt text](https://github.com/gui-murray/treinamento-algoritmos-IA/blob/main/img6_accuracy_decision_tree.png?raw=true)

Agora, vamos comparar com o outro algoritmo (SVM). Detalhes do ajuste:

![alt text](https://github.com/gui-murray/treinamento-algoritmos-IA/blob/main/img7_svm_model_trained.png?raw=true)

Acurácia e matriz de confusão do algoritmo SVM. Aparentemente possui acurácia maior (84%), errando menos que o algoritmo das Árvores de Decisão:

![alt text](https://github.com/gui-murray/treinamento-algoritmos-IA/blob/main/img8_accuracy_svm.png?raw=true)

Este mesmo procedimento poderia ser feito para outros algoritmos de classificação com IA.
