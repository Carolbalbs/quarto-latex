# quarto-latex — artigo científico em Markdown, dois templates LaTeX

Esqueleto para escrever um artigo científico uma única vez, em Markdown
(Quarto), e publicá-lo em **dois templates LaTeX diferentes** e em **HTML**,
sem duplicar conteúdo:

| Saída | Comando | Resultado |
|:--|:--|:--|
| PDF **WebMedia** (duas colunas, ACM `sigconf`) | `quarto render artigo/webmedia.qmd` | `docs/artigo/webmedia.pdf` |
| PDF **preprint** (coluna única, estilo arXiv) | `quarto render artigo/preprint.qmd` | `docs/artigo/preprint.pdf` |
| Site HTML + os dois PDFs | `quarto render` | `docs/` |
| Pré-visualização enquanto escreve | `quarto preview` | navegador com recarga automática |

Trocar de template **não exige nenhuma alteração no texto**: é só mudar o
arquivo de entrada.

## Começando

```bash
git clone <seu-fork> meu-artigo
cd meu-artigo
quarto install tinytex     # uma vez, se você ainda não tem LaTeX
quarto render
```

Depois:

1. edite `artigo/_metadata.yml` (título, autores, afiliações, resumo,
   palavras-chave, dados do evento);
2. escreva em `artigo/sections/*.qmd`;
3. coloque figuras em `artigo/figuras/` e referências em
   `artigo/referencias.bib`;
4. renderize.

## Estrutura

```
.
├── _quarto.yml                 # projeto website + tema do site
├── index.qmd                   # página inicial do site (links de download)
├── artigo/
│   ├── _metadata.yml           # ÚNICA fonte dos metadados do artigo
│   ├── _corpo.qmd              # lista de seções incluídas (ordem do artigo)
│   ├── index.qmd               # entrada → HTML
│   ├── webmedia.qmd            # entrada → PDF WebMedia
│   ├── preprint.qmd            # entrada → PDF preprint
│   ├── sections/*.qmd          # o texto do artigo
│   ├── figuras/                # imagens
│   └── referencias.bib         # bibliografia
├── _extensions/
│   ├── webmedia/               # formato `webmedia-pdf` (webmedia.cls + partials)
│   └── preprint/               # formato `preprint-pdf` (externalized.cls + partials)
└── .github/workflows/build.yml # CI: renderiza, publica no Pages, anexa PDFs
```

Os três arquivos de entrada (`index.qmd`, `webmedia.qmd`, `preprint.qmd`) são
casca: cada um só declara seu formato e inclui `_corpo.qmd`. São separados de
propósito — o Quarto não consegue gerar dois formatos PDF customizados a partir
de um mesmo arquivo na mesma passada.

Para **criar uma seção**: adicione `artigo/sections/06-minha-secao.qmd` e um
`{{< include sections/06-minha-secao.qmd >}}` em `artigo/_corpo.qmd`.

## Metadados por template

Todos os metadados ficam em `artigo/_metadata.yml`. Os campos gerais (título,
`author`, `affiliations`, `abstract`, `keywords`, `date`, `lang`,
`bibliography`) alimentam os dois templates. Os blocos abaixo são específicos e
ignorados pelo outro formato:

```yaml
webmedia:
  abstract-title: "Resumo"      # título da seção de resumo
  event: webmedia               # \setevent
  acronym: "WebMedia'2026"      # sigla nos \proceedingsDetails
  proceedings: "Proceedings of the Brazilian Symposium on Multimedia and the Web"
  year: 2026
  location: "Lavras/MG, Brazil"
  issn: "2966-2753"
  format: sigconf               # opcional: outro formato da classe
  print-acmref: false           # opcional: imprimir o bloco de referência ACM

preprint:
  accent: "004098"              # cor de destaque (HEX, sem #)
  abstract-title: "Resumo"
  twocolumn: false              # true → duas colunas
  correspondence: [fulano@exemplo.br]
  correspondence-label: "Contato"
  date-label: "Data"
  equal-contrib-note: "Contribuição igual"   # nota do marcador *
  corresponding-note: "Autor correspondente" # nota do marcador †
```

Os marcadores `*` e `†` saem dos atributos de cada autor:

```yaml
author:
  - name: Fulana de Tal
    email: fulana@exemplo.br
    affiliations: [{ref: inst1}]
    attributes:
      corresponding: true       # † no template de preprint
      equal-contributor: true   # * no template de preprint
```

## Citações e bibliografia

As citações usam `citeproc` (padrão do Quarto), o que mantém HTML e os dois
PDFs consistentes: `[@chave]`, `@chave`, `[@a; @b]`. Para trocar o estilo,
use `csl: meu-estilo.csl` em `artigo/_metadata.yml`.

As duas classes LaTeX carregam `natbib` por conta própria, o que normalmente
quebra a saída do citeproc; os partials já neutralizam esse conflito. Por isso
**não use `cite-method: natbib`** aqui sem ajustar os partials.

## Adicionando um terceiro template

1. crie `_extensions/<nome>/_extension.yml` declarando um formato `pdf`, com
   `format-resources` (sua `.cls`) e `template-partials`;
2. copie os três partials de uma extensão existente e adapte o bloco de título
   à sua classe;
3. crie `artigo/<nome>.qmd` com `format: <nome>-pdf` e
   `{{< include _corpo.qmd >}}`;
4. acrescente o arquivo em `project: render:` no `_quarto.yml`.

## Requisitos

- [Quarto](https://quarto.org) ≥ 1.4;
- uma distribuição LaTeX — `quarto install tinytex` resolve, e os pacotes
  faltantes (`tcolorbox`, `fontawesome5`, `titlesec`, `tocloft`, `nicematrix`,
  `libertine`, `newtxmath`…) são instalados automaticamente no primeiro
  `render`.

### Limitação conhecida: colchetes no caminho

O Quarto não localiza os *template partials* quando o caminho do projeto contém
`[` ou `]` (ex.: `~/Área de trabalho/[C2D2]quarto-latex`), e o render falha com
`Template partial ... was not found`. Use um diretório sem colchetes.

## Créditos

As classes LaTeX redistribuídas aqui são de terceiros — veja
[NOTICE.md](NOTICE.md) para origem, licenças e modificações.
