# Panel

<a href="https://www.pharo.org">
    <img alt="Pharo" src="https://img.shields.io/static/v1?style=for-the-badge&message=Pharo&color=3297d4&logo=Harbor&logoColor=FFFFFF&label=" />
</a>

Panel is a flexible panel layout for Pharo completely written in Bloc and Toplo. It allows IDE like env to arrange panels, split areas into rows and columns, and move tools/widgets between different sections to organise your workspace.

### Loading latest development version

```smalltalk
Metacello new
    baseline: 'Panel';
    repository: 'github://pharo-graphics/Panel:master/';
    onConflict: [ :ex | ex useIncoming ];
    onUpgrade: [ :ex | ex useIncoming ];
    load
```
