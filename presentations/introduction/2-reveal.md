<!-- Forces hidden fragments to no take up space
 https://stackoverflow.com/questions/26820084/34111675#34111675 -->
<style>
.fragment.visible:not(.current-fragment):not(.keep-fragment-alive) {
    display: none;
    height:0px;
    line-height: 0px;
    font-size: 0px;
}
</style>

## Reveal.js background

Trino presentations are built on [reveal.js](https://revealjs.com/), an HTML presentation framework.

The [markdown plugin](https://revealjs.com/markdown/#markdown-plugin) is used to represent most slide
content in modular external markdown files.

The following slides contain some brief intro to reveal.js using markdown

-vertical

#### Initializing reveal and markdown in index.html

```html[1,3,6,10]
<script src="../../reveal/dist/reveal.js"></script>
<script src="../../reveal/plugin/notes/notes.js"></script>
<script src="../../reveal/plugin/markdown/markdown.js"></script>
<script src="../../reveal/plugin/highlight/highlight.js"></script>
<script>
 Reveal.initialize({
   hash: true,
   parallaxBackgroundImage: '../../assets/logos/space-background-faded.svg',
   parallaxBackgroundSize: '2853px 1000px',
   plugins: [ RevealMarkdown, RevealHighlight, RevealNotes ]
 });
```

-vertical

#### HTML content in index.html

```html
<div class="reveal">
  <div class="slides">
    <section class="title-slide">
      ...
    </section>
    <section data-markdown="1-example.md"
      data-separator="~horizontal~"
      data-separator-vertcal="~vertical~"
      data-charset="iso-8859-15"></section>
    <section data-markdown="2-example.md"
      ...
  </div>
</div>
```

-vertical

#### Markdown slide layout

Slides can be vertical or horizontal of eachother.

```markdown
## Slide 1

~vertical~

## Slide 1.2

~horizontal~

## Slide 2

~vertical~

## Slide 2.2

```

<!-- .element: class="fragment" data-fragment-index="0" -->

The above markdown would create four slides in the following orientation.

<!-- .element: class="fragment" data-fragment-index="0" -->

<style>
.tb table, .tb tr, .tb th, .tb td {
  border: 1px solid;
}
</style>

| Slide 1 | Slide 2 |
| ----------- | ----------- |
| Slide 1.2 | Slide 2.2 |

<!-- .element: class="fragment tb" data-fragment-index="1" -->

-vertical

## Using Markdown: Headings

```markdown
## Using Markdown: Headings

# H1
## H2
### H3
#### H4
##### H5

```

<!-- .element: class="fragment" data-fragment-index="0" -->

# H1 <!-- .element: class="fragment fade-in" data-fragment-index="1" -->
## H2 <!-- .element: class="fragment fade-in" data-fragment-index="1" -->
### H3 <!-- .element: class="fragment fade-in" data-fragment-index="1" -->
#### H4 <!-- .element: class="fragment fade-in" data-fragment-index="1" -->
##### H5 <!-- .element: class="fragment fade-in" data-fragment-index="1" -->

-vertical

## Using Markdown: Formatting

```markdown
## Using Markdown: Formatting

_Just some italics_

**Just some bold text**

***Just some bold italics***

> Just a quote

`Just some code`
```

<!-- .element: class="fragment" data-fragment-index="0" -->

Just some text with a [link](https://trino.io)

<!-- .element: class="fragment fade-in" data-fragment-index="1" -->

_Just some italics_ <!-- .element: class="fragment fade-in" data-fragment-index="1" -->

**Just some bold text** <!-- .element: class="fragment fade-in" data-fragment-index="1" -->

***Just some bold italics*** <!-- .element: class="fragment fade-in" data-fragment-index="1" -->

> Just a quote  <!-- .element: class="fragment fade-in" data-fragment-index="1" -->

`Just some code` <!-- .element: class="fragment fade-in" data-fragment-index="1" -->

-vertical

## Using Markdown: Lists

```markdown
## Using Markdown: Lists

* one
* two
  1. two.one
  1. two.two
* three
```

<!-- .element: class="fragment" data-fragment-index="0" -->

* one
* two
  1. two.one
  1. two.two
* three

<!-- .element: class="fragment fade-in" data-fragment-index="1" -->

-vertical

## Using Markdown: Code

```markdown
## Using Markdown: Code

```sql[1,3|2]
SELECT a, b, c
FROM d.e.f
WHERE g = h
```                                                                                          . 

```

<!-- .element: class="fragment" data-fragment-index="0" -->

```sql[1,3|2]
SELECT a, b, c
FROM d.e.f
WHERE g = h
```

<!-- .element: class="fragment fade-in keep-fragment-alive" data-fragment-index="1" -->

-vertical

## Using Markdown: Element and slide attributes

```markdown
<!-- .slide: data-background="#212121" -->

Links to [external sites](https://github.com/trinodb/presentations)

<!-- .element: class="fragment" data-fragment-index="2" -->

Links to [other slides](#/0)

<!-- .element: class="fragment" data-fragment-index="1" -->
```

<!-- .slide: data-background="#212121" -->

Links to [external sites](https://github.com/trinodb/presentations)

<!-- .element: class="fragment" data-fragment-index="2" -->

Links to [other slides](#/0)

<!-- .element: class="fragment" data-fragment-index="1" -->


