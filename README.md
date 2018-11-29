# fishrosetta
Translation package for CSAS documents

A package to translate words or short phrases between languages (e.g. French to English, English to French, etc.).
 
This would apply to figure labels to produce separate figures in two languages, or a single figure with labels in two languages. It can also
be used for other text (such as table headings), but is not intended for translation of complete sentences.

In particular, it should be useful for automatically producing translated technical figures  to go into Research Documents and presentations. This is done when building the figures (in  R) and saves someone having to manually edit the figure (in, say, Photoshop). This preserves the quality and the output formats of figures in both languages, and is especially time-saving when the same figure axes are the same for multiple figures (e.g. a biomass estimate for multiple model runs of a stock assessment).

The package has a built-in .csv file of English-French translations of common technical fisheries terms (that are often incorrectly translated by generic automatic translators). Users can add to this or use their own file. They can also add to the ever-expanding list of common terms using the instructions below.

This is currently implemented for French-English translations but could be expanded to other languages (e.g. Inuktitut).

## Examples

```
years <- 1980:2018
biomass <- 2000 * rlnorm(length(years, 0, 1))
plot(years,
     biomass,
     type = "o"
     xlab = trans("Year"),
     ylab = trans("Biomass (t)")
)

plot(years,
     biomass,
     type = "o"
     xlab = trans("Année"),
     ylab = trans("Biomasse (t)")
)

plot(years,
     biomass,
     type = "o"
     xlab = trans("Année"),
     ylab = paste("Biomass (t); ", trans("Biomass (t)"))
)
```

## Instructions for updating the list of translated scientific terms

