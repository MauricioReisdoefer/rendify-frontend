# 📈 Rendify

Rendify é um aplicativo em Flutter que simula a compra e gestão de ações, com recursos de gráficos, configurações e dúvidas frequentes.
O projeto conta com suporte a **traduções** via `easy_localization` e interface responsiva com uso de `Google Fonts` e `Material Design`.

## ❓ Para que foi feito o Rendify?
A ideia do Rendify surgiu por conta da dificuldade das pessoas em entender o mercado de ações, fazendo com que muitas delas desistam com o medo de acabar no prejuízo.

Por isso, o objetivo principal do Rendify é oferecer um ambiente seguro e intuitivo para que usuários aprendam a investir de forma prática. Ao simular a compra e venda de ativos — com ferramentas como gráficos, simulações e feedback visual — ele ajuda o usuário a entender como o mercado funciona sem risco real.

## 🚀 Principais Funcionalidades

* **BottomBar**
  O aplicativo oferece uma barra horizontal para navegação entre as telas do app.

* **Simulador**
  Simulação de compra/venda de ações e exibição de resultados.

* **Valor das Ações**
  Estando no simulador, é possível visualizar gráficos do histórico dos valores das ações disponíveis com `fl_chart`.

* **Configurações**
  Alteração de preferências, idiomas e formatações.

* **Dúvidas Frequentes**
  Lista de perguntas e respostas comuns para possíveis dúvidas do usuário.


## 🛠️ Tecnologias Utilizadas

* **Flutter** (UI principal)
* **easy\_localization** (tradução de textos)
* **google\_fonts** (customização de fontes)
* **fl\_chart** (gráficos de ações)
* **currency\_text\_input\_formatter** (formatação de valores monetários)

## ⚙️ API (TwelveData)
No Rendify, a API Twelve Data entra como o “coração” do abastecimento de informações financeiras — é ela que fornece as cotações, séries históricas e indicadores técnicos necessários para o app cumprir sua função de simular e analisar investimentos.

No contexto do projeto, ela possui as funções de:

### 📈 Obter preços em tempo real

O app consulta a Twelve Data para trazer a cotação atual de ações, criptomoedas ou outros ativos que o usuário deseja acompanhar. Isso permite que o simulador calcule ganhos ou perdas com base no valor mais atualizado.

### 📜 Fornecer histórico de preços

O endpoint /time_series é usado para buscar dados passados, essenciais para gráficos e projeções. Isso dá ao usuário a possibilidade de entender o comportamento do ativo ao longo do tempo antes de tomar decisões.

### 📊 Calcular métricas e indicadores técnicos

Alguns indicadores como SMA (Média Móvel Simples) e RSI (Índice de Força Relativa) podem ser obtidos diretamente da API. Isso poupa processamento no lado do app e garante dados consistentes.

## 📦 Como Testar

1. **Instale o Flutter**
   Siga o guia oficial: [Flutter Install](https://flutter.dev/docs/get-started/install)

2. **Clone o repositório**

   ```bash
   git clone https://github.com/MauricioReisdoefer/rendify-frontend.git
   cd rendify-frontend
   ```

3. **Instale as dependências**

   ```bash
   flutter pub get
   ```

4. **Execute o aplicativo**

   ```bash
   flutter run
   ```
