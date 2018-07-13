# ggplot2: colors

### 1. Discrete

#### 1.1 Default colors

```R
# Box plot
bp<-ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose)) +
  geom_boxplot()
# Scatter plot
sp<-ggplot(mtcars, aes(x=wt, y=mpg, color=cyl)) + geom_point()
```

<p><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-group-color-1.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-group-color-2.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"></p>

> The lightness (l) and the chroma (c, intensity of color) of the default (hue) colors can be modified using the functions *scale_hue* as follow : 

  ```R
  # Box plot
  bp + scale_fill_hue(l=40, c=35)
  # Scatter plot
  sp + scale_color_hue(l=40, c=35)
  ```

  <p><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-group-color-luminance-chroma-1.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-group-color-luminance-chroma-2.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"></p>

#### 1.2 Change colors manually

A custom color palettes can be specified using the functions :

- `scale_fill_manual() `for box plot, bar plot, violin plot, etc

- `scale_color_manual()` for lines and points

```R
# Box plot
bp + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# Scatter plot
sp + scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))
```

  <p><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-manual-1.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-manual-2.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"></p>

Note that, the argument ***breaks*** can be used to control the appearance of the legend. This holds true also for the other `scale_xx()` functions. 

```R
# Box plot
bp + scale_fill_manual(breaks = c("2", "1", "0.5"), 
                       values=c("red", "blue", "green"))
# Scatter plot
sp + scale_color_manual(breaks = c("8", "6", "4"),
                        values=c("red", "blue", "green"))
```

<p><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-manual-use-breaks-1.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-manual-use-breaks-2.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"></p>

#### 1.3 Change colors automatically

##### 1.3.1 Use RColorBrewer palettes

<p>The color palettes available in the ***RColorBrewer*** package are described here : <a href="/english/wiki/colors-in-r">color in R</a>.</p>

```r
# Box plot
bp + scale_fill_brewer(palette="Dark2")
# Scatter plot
sp + scale_color_brewer(palette="Dark2")
```

<p><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-group-color-rcolorbrewer-1.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-group-color-rcolorbrewer-2.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"></p>

<p><img src="http://www.sthda.com/sthda/RDoc/images/rcolorbrewer.png"></p>

##### 1.3.2 Use Wes Anderson color palettes

```R
install.packages("wesanderson")
library(wesanderson)
```

```R
# Box plot
bp+scale_fill_manual(values=wes_palette(n=3, name="GrandBudapest"))
# Scatter plot
sp+scale_color_manual(values=wes_palette(n=3, name="GrandBudapest"))
```

<p><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-group-color-wesanderson-1.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-group-color-wesanderson-2.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"></p>

<p><img alt="wesanderson-color palettes" src="http://www.sthda.com/sthda/RDoc/images/wesanderson-color.png"></p>

##### 1.3.3 Use gray colors

The functions to use are :

- **scale_colour_grey()** for points, lines, etc

- **scale_fill_grey()** for box plot, bar plot, violin plot, etc

```R
# Box plot
bp + scale_fill_grey() + theme_classic()

# Scatter plot
sp + scale_color_grey() + theme_classic()
```

  <p><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-grey-1.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-grey-2.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"></p>

```R
# Box plot
bp + scale_fill_grey(start=0.8, end=0.2) + theme_classic()
# Scatter plot
sp + scale_color_grey(start=0.8, end=0.2) + theme_classic()
```

> default value for the arguments *start* and *end* are : start = 0.2, end = 0.8 

<p><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-grey-change-value-1.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-grey-change-value-2.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"></p>

<hr/>

### 2. Continuous

The graph can be colored according to the values of a continuous variable using the functions :

- `scale_color_gradient()`, `scale_fill_gradient()` for sequential gradients between two colors
- `scale_color_gradient2()`, `scale_fill_gradient2()` for diverging gradients
- `scale_color_gradientn()`, `scale_fill_gradientn()` for gradient between n colors

#### 2.1 Default colors

```R
#scatter plot
sp2<-ggplot(mtcars, aes(x=wt, y=mpg, color=qsec)) + geom_point()
# Histogram
set.seed(1234)
x <- rnorm(200)
hp<-qplot(x =x, fill=..count.., geom="histogram") 
```

<p><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-gradient-1.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-fill-gradient-1.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"></p>

#### 2.2 Change colors manually

##### 2.2.1 Scatter plot

```R
# Change the low and high colors
# Sequential color scheme
sp2+scale_color_gradient(low="blue", high="red")
# Diverging color scheme
mid<-mean(mtcars$qsec)
sp2+scale_color_gradient2(midpoint=mid, low="blue", mid="white",
                     high="red", space ="Lab" )
```

<p><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-gradient-2.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-gradient-3.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"></p>

##### 2.2.2 histogram

```R
# Sequential color scheme
hp+scale_fill_gradient(low="blue", high="red")
```

<p><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-fill-gradient-2.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"></p>

#### 2.3 Change colors automatically

```R
# Scatter plot
sp3<-ggplot(mtcars, aes(x=wt, y=mpg, color=mpg)) + geom_point()
# Gradient between n colors
sp3+scale_color_gradientn(colours = rainbow(5))
```

<p><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-gradientn-1.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"><img src="http://www.sthda.com/sthda/RDoc/figure/ggplot2/ggplot2-color-scale-color-gradientn-2.png" title="ggplot2 color, graph, R software" alt="ggplot2 color, graph, R software" width="240"></p>

