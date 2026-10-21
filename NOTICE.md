# Créditos e licenças dos templates LaTeX

Este repositório redistribui dois arquivos de classe LaTeX de terceiros.
O código próprio do projeto (partials, configuração do Quarto, conteúdo de
exemplo e workflow de CI) está sob a licença do repositório; as classes abaixo
mantêm as licenças originais.

## `_extensions/webmedia/webmedia.cls`

Classe dos **Anais do WebMedia** (Simpósio Brasileiro de Sistemas Multimídia e
Web), adaptada de `acmart.cls` da ACM. Obtida do template oficial publicado no
Overleaf:

- <https://www.overleaf.com/latex/templates/webmedia-template/ckjcbscxjjjh>
- Licença indicada na página do template: Creative Commons CC BY 4.0.
- `acmart.cls`, da qual deriva, é distribuída pela ACM sob a LPPL.

Arquivo redistribuído sem modificações.

## `_extensions/preprint/externalized.cls`

Classe de preprint usada no artigo *"Externalization in LLM Agents: A Unified
Review of Memory, Skills, Protocols and Harness Engineering"*
(arXiv:2604.08224), obtida do código-fonte TeX do próprio preprint
(<https://arxiv.org/e-print/2604.08224>), publicado sob Creative Commons
CC BY 4.0.

Modificações feitas aqui, assinaladas no arquivo com o prefixo
`%% [quarto-latex]`:

- declaração de `\addtolist` com `\providecommand`, para que a classe compile
  de forma autônoma.

**Não redistribuímos** os arquivos de fonte do diretório `theme/` do pacote
original (ByteDance Sans, `.pfb`/`.tfm`/`.afm`), cujo licenciamento não é
aberto. A classe já faz fallback para Helvetica (`helvet`), que é o que este
projeto utiliza.
